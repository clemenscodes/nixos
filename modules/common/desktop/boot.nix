{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.lanzaboote.nixosModules.lanzaboote];
  environment = {
    systemPackages = with pkgs; [sbctl];
  };
  boot = {
    kernelPackages = lib.mkDefault pkgs.linuxPackages_xanmod_latest;
    supportedFilesystems = [ "ntfs" ];
    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
    loader = {
      systemd-boot = {
        enable = lib.mkForce false;
      };
      grub = {
        enable = lib.mkForce false;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback.out
    ];
    kernelModules = [
      "v4l2loopback"
      "kvm_intel"
      "virtio"
    ];
    extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';
  };
}
