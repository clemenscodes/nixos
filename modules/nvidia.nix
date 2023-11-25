{ pkgs, config, lib, ... }: {
  boot = {
    kernelParams = [
      "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    ];
  };
  services = {
    xserver = {
      videoDrivers = [ "nvidia" ];
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
      open = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.production;
    };
  };
  programs = {
    zsh = {
      loginShellInit = ''
        export GDK_BACKEND=wayland,x11
        export GBM_BACKEND=nvidia-drm
        export SDL_VIDEODRIVER=wayland
        export CLUTTER_BACKEND=wayland
        export __GLX_VENDOR_LIBRARY_NAME=nvidia
        export LIBVA_DRIVER_NAME=nvidia
      '';
    };
  };
}

