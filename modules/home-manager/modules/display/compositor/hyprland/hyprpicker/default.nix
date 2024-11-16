{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.display.compositor.hyprland;
in
  with lib; {
    options = {
      modules = {
        display = {
          compositor = {
            hyprland = {
              hyprpicker = {
                enable = mkEnableOption "Enable hyprpicker" // {default = cfg.enable;};
              };
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.hyprpicker.enable) {
      home = {
        packages = [pkgs.hyprpicker];
      };
    };
  }
