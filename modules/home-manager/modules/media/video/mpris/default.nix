{
  config,
  lib,
  ...
}: let
  cfg = config.modules.media.video;
in
  with lib; {
    options = {
      modules = {
        media = {
          video = {
            mpris = {
              enable = mkEnableOption "Enable mpris" // {default = cfg.enable;};
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.mpris.enable) {
      services = {
        mpd-mpris = {
          enable = cfg.enable;
        };
      };
    };
  }
