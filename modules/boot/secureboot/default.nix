{
  inputs,
  pkgs,
  lib,
  ...
}: {config, ...}: let
  cfg = config.modules.boot;
in {
  imports = [inputs.lanzaboote.nixosModules.lanzaboote];
  options = {
    modules = {
      boot = {
        secureboot = {
          enable = lib.mkEnableOption "Enables secureboot" // {default = false;};
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.secureboot.enable) {
    environment = {
      systemPackages = with pkgs; [sbctl];
    };
    boot = {
      lanzaboote = {
        enable = true;
        pkiBundle = "/etc/secureboot";
      };
    };
  };
}
