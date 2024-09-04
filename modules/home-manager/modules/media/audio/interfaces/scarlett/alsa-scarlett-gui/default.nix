{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.media.audio.interfaces.scarlett;
in
  with lib; {
    options = {
      modules = {
        media = {
          audio = {
            interfaces = {
              scarlett = {
                alsa-scarlett-gui = {
                  enable = mkEnableOption "Enable alsa-scarlett-gui" // {default = cfg.enable;};
                };
              };
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.alsa-scarlett-gui.enable) {
      home = {
        packages = with pkgs; [alsa-scarlett-gui];
      };
    };
  }
