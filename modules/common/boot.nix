{ config, lib, pkgs, ... }: {
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
    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback.out
    ];
    kernelModules = [ "v4l2loopback" ];
    extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';
  };
}
