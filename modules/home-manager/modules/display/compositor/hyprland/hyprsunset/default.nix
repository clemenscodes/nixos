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
              hyprsunset = {
                enable = mkEnableOption "Enable hyprsunset" // {default = cfg.enable;};
              };
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.hyprsunset.enable) {
      home = {
        packages = [pkgs.hyprsunset];
      };
    };
  }
