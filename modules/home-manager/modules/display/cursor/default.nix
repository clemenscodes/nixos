{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.display;
in
  with lib; {
    options = {
      modules = {
        display = {
          cursor = {
            enable = mkEnableOption "Enable a cool cursor" // {default = cfg.enable;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.cursor.enable) {
      home = {
        pointerCursor = {
          name = "catppuccin-macchiato-blue-cursors";
          package = pkgs.catppuccin-cursors.macchiatoBlue;
          size = 16;
        };
      };
    };
  }
