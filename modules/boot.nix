{ lib, ... }: {
  boot = {
    kernelParams = [
      "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    ];
    loader = {
      systemd-boot = {
        enable = lib.mkForce false;
      };
      grub = {
        enable = lib.mkForce true;
	device = "nodev";
	efiSupport = true;
	useOSProber = false;
      };
      efi = {
        canTouchEfiVariables = true;
	efiSysMountPoint = "/boot";
      };
    };
  };
}
