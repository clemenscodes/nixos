{
  lib,
  config,
  ...
}: let
  cfg = config.modules.gaming;
in
  with lib; {
    options = {
      modules = {
        gaming = {
          gamescope = {
            enable = mkEnableOption "Enable gamescope" // {default = cfg.enable;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.gamescope.enable) {
      programs = {
        gamescope = {
          enable = cfg.gamescope.enable;
        };
      };
    };
  }
