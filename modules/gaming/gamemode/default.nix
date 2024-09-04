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
          gamemode = {
            enable = mkEnableOption "Enable gamemode" // {default = cfg.enable;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.gamemode.enable) {
      programs = {
        gamemode = {
          enable = cfg.gamemode.enable;
        };
      };
    };
  }
