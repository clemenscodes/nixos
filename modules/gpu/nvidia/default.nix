{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.gpu;
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
in {
  imports = [./scripts];
  options = {
    modules = {
      gpu = {
        nvidia = {
          enable = mkEnableOption "Enables NVIDIA GPU support" // {default = false;};
        };
      };
    };
  };
  config = mkIf (cfg.enable && cfg.nvidia.enable) {
    modules = {
      gpu = {
        vendor = "nvidia";
      };
    };
    environment = {
      systemPackages = with pkgs; [
        nvidia-offload
        cudaPackages.cudatoolkit
        cudaPackages.cudnn
        nvtop-amd
        mesa
        vulkan-tools
        vulkan-loader
        vulkan-validation-layers
        vulkan-extension-layer
        libva
        libva-utils
      ];
    };
    boot = {
      kernelModules = [
        "nvidia_uvm"
      ];
      kernelParams = [
        "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
      ];
      blacklistedKernelModules = ["nouveau"];
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
          finegrained = true;
        };
        prime = {
          offload = {
            enable = true;
            enableOffloadCmd = true;
          };
          nvidiaBusId = "PCI:1:0:0";
          intelBusId = "PCI:0:2:0";
        };
        open = true;
        nvidiaSettings = false;
        nvidiaPersistenced = true;
        # CS2 doesnt boot up in stable or beta
        # @see https://forums.developer.nvidia.com/t/cs2-stuck-on-valve-logo-on-startup-545-beta-branch/269778
        package = config.boot.kernelPackages.nvidiaPackages.production;
      };
      graphics = {
        extraPackages = with pkgs; [nvidia-vaapi-driver];
        extraPackages32 = with pkgs.pkgsi686Linux; [nvidia-vaapi-driver];
      };
    };
    programs = {
      zsh = {
        loginShellInit = ''
          export GDK_BACKEND=wayland,x11
          export XDG_SESSION_TYPE=wayland
          export SDL_VIDEODRIVER=wayland
          export CLUTTER_BACKEND=wayland
          export GBM_BACKEND=nvidia-drm
          export LIBVA_DRIVER_NAME=nvidia
          export __GLX_VENDOR_LIBRARY_NAME=nvidia
          export __GL_GSYNC_ALLOWED=1
          export __GL_VRR_ALLOWED=1
        '';
      };
    };
  };
}
