{
  pkgs,
  config,
  lib,
  ...
}:
let 
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
in
{
  environment = {
    systemPackages = with pkgs.cudaPackages; [
      nvidia-offload
      cudatoolkit cudnn
    ];
  };
  boot = {
    kernelParams = [
      "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    ];
  };
  services = {
    xserver = {
      videoDrivers = ["nvidia"];
    };
  };
  hardware = {
    nvidia = {
      modesetting = {
        enable = true;
      };
      powerManagement = {
        # On wayland, suspend does not turn the screen back on when using the open source driver
        # Use proprietary driver if you want to use the suspend feature
        # as long as this issue is not fixed
        # @see https://github.com/NVIDIA/open-gpu-kernel-modules/issues/360
        enable = true;
        finegrained = false;
      };
      prime = {
    		offload = {
    			enable = false;
    			enableOffloadCmd = false;
    		};
		    nvidiaBusId = "PCI:1:0:0";
      	intelBusId = "PCI:0:2:0";
      };
      open = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };
  programs = {
    zsh = {
      loginShellInit = ''
        export GDK_BACKEND=wayland,x11
        export GBM_BACKEND=nvidia-drm
        export XDG_SESSION_TYPE=wayland
        export SDL_VIDEODRIVER=wayland
        export CLUTTER_BACKEND=wayland
        export __GLX_VENDOR_LIBRARY_NAME=nvidia
        export __GL_GSYNC_ALLOWED=1
        export __GL_VRR_ALLOWED=1
        export LIBVA_DRIVER_NAME=nvidia
      '';
    };
  };
}
