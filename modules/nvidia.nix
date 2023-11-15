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
}

