{ config, lib, ... }: {
  services = {
    xserver = {
      videoDrivers = [ "nvidia" ];
    };
  };
  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
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
}

