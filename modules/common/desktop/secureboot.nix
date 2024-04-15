{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:
with lib; let
  cfg = config.secureboot;
in {
  imports = [inputs.lanzaboote.nixosModules.lanzaboote];
  options = {
    secureboot = {
      enable = mkEnableOption "Enables secureboot";
    };
  };
  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [sbctl];
    };
    boot = {
      lanzaboote = {
        enable = true;
        pkiBundle = "/etc/secureboot";
      };
      loader = {
        systemd-boot = {
          enable = lib.mkForce false;
        };
        efi = {
          efiSysMountPoint = "/boot";
        };
      };
    };
  };
}
