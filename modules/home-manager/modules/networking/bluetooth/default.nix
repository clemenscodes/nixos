{
  config,
  osConfig,
  lib,
  ...
}: let
  cfg = config.modules.networking;
  osCfg = osConfig.modules.networking;
in
  with lib; {
    imports = [
      ./blueman
    ];
    options = {
      modules = {
        networking = {
          bluetooth = {
            enable = mkEnableOption "Enable bluetooth" // {default = osCfg.bluetooth.enable && cfg.enable;};
          };
        };
      };
    };
  }
