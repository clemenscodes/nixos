{inputs}: {
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules;
  isDesktop = config.modules.display.gui != "headless";
  inherit (cfg.boot) efiSupport device;
in
  with lib; {
    imports = [
      (import ./secureboot {inherit inputs;})
      ./themes
    ];
    options = {
      modules = {
        boot = {
          enable = mkEnableOption "Enable bootloader" // {default = cfg.enable && isDesktop;};
          efiSupport = mkEnableOption "Enable UEFI" // {default = cfg.boot.enable;};
          device = mkOption {
            type = types.str;
            default = "nodev";
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.boot.enable && isDesktop) {
      environment = {
        systemPackages = [
          pkgs.ntfs3g
          pkgs.exfat
          pkgs.gparted
        ];
      };
      boot = {
        kernelPackages = lib.mkDefault pkgs.linuxPackages_xanmod_latest;
        supportedFilesystems = ["ext4" "ntfs" "exfat"];
        loader = {
          systemd-boot = {
            enable = efiSupport;
          };
          grub = {
            inherit efiSupport device;
            enable = lib.mkForce (!efiSupport);
            copyKernels = efiSupport;
            useOSProber = efiSupport;
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
        ];
        extraModprobeConfig = ''
          options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
        '';
      };
    };
  }
