{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.media.editing;
in
  with lib; {
    options = {
      modules = {
        media = {
          editing = {
            inkscape = {
              enable = mkEnableOption "Enable inkscape" // {default = cfg.enable;};
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.inkscape.enable) {
      home = {
        packages = with pkgs; [
          inkscape-with-extensions
        ];
      };
    };
  }
