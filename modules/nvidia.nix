{ config, lib, ... }: {
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
        enable = false;
	finegrained = false;
      };
      open = true;
      nvidiaSettings = true;
      forceFullCompositionPipeline = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
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
        export __GL_GSYNC_ALLOWED=1
        export __GL_VRR_ALLOWED=1
      '';
    };
  };
}

