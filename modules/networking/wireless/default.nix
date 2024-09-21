{
  lib,
  config,
  ...
}: let
  cfg = config.modules.networking;
in
  with lib; {
    imports = [
      ./eduroam
    ];
    options = {
      modules = {
        networking = {
          wireless = {
            enable = mkEnableOption "Enable wireless configuration" // {default = false;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.wireless.enable) {
      networking = {
        wireless = mkIf config.modules.security.sops.enable {
          enable = cfg.wireless.enable;
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
