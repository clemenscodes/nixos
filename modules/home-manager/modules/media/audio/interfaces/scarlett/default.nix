{
  config,
  lib,
  ...
}: let
  cfg = config.modules.media.audio.interfaces;
in
  with lib; {
    imports = [
      ./alsa-scarlett-gui
      ./scarlett2
    ];
    options = {
      modules = {
        media = {
          audio = {
            interfaces = {
              scarlett = {
                enable = mkEnableOption "Enable scarlett audio interfaces" // {default = cfg.enable;};
              };
            };
          };
        };
      };
    };
  }
