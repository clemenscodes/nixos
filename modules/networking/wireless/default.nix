{
  inputs,
  pkgs,
  lib,
  ...
}: {config, ...}: let
  cfg = config.modules.networking;
in {
  imports = [
    (import ./eduroam {inherit inputs pkgs lib;})
  ];
  options = {
    modules = {
      networking = {
        wireless = {
          enable = lib.mkEnableOption "Enable wireless configuration" // {default = false;};
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.wireless.enable) {
    networking = {
      wireless = lib.mkIf config.modules.security.sops.enable {
        inherit (cfg.wireless) enable;
        userControlled = {
          enable = true;
        };
        secretsFile = config.sops.secrets.wifi.path;
        networks = {
          "ext:home_uuid" = {
            priority = 1;
            pskRaw = "ext:home_psk";
          };
          "ext:alt_home_uuid" = {
            priority = 2;
            pskRaw = "ext:alt_home_psk";
          };
        };
      };
    };
  };
}
