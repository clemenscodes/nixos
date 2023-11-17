{ lib, pkgs, ... }: {
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
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
