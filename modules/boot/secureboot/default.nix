{inputs}: {
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.modules.boot;
in {
  imports = [inputs.lanzaboote.nixosModules.lanzaboote];
  options = {
    modules = {
      boot = {
        secureboot = {
          enable = mkEnableOption "Enables secureboot" // {default = false;};
        };
      };
    };
  };
  config = mkIf (cfg.enable && cfg.secureboot.enable) {
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
