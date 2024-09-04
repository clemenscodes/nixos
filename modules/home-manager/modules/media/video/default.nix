{
  lib,
  config,
  ...
}: let
  cfg = config.modules.media;
in
  with lib; {
    imports = [
      ./mpv
      ./mpris
      ./obs
      ./vhs
    ];
    options = {
      modules = {
        media = {
          video = {
            enable = mkEnableOption "Enable video" // {default = cfg.enable;};
          };
        };
      };
    };
  }
