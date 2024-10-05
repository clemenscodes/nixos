{
  lib,
  config,
  ...
}: let
  cfg = config.modules.networking;
in
  with lib; {
    options = {
      modules = {
        networking = {
          stevenblack = {
            enable = mkEnableOption "Enable stevenblack" // {default = cfg.enable;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.stevenblack.enable) {
      networking = {
        stevenblack = {
          enable = cfg.stevenblack.enable;
          block = ["fakenews" "gambling" "porn"];
        };
      };
    };
  }
