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
              xwayland = {
                enable = mkEnableOption "Enable xwayland" // {default = cfg.enable;};
              };
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.xwayland.enable) {
      home = {
        packages = [pkgs.xwaylandvideobridge];
      };
      wayland = {
        windowManager = {
          hyprland = {
            xwayland = {
              enable = cfg.xwayland.enable;
            };
            extraConfig =
              /*
              hyprlang
              */
              ''
                windowrulev2 = opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$
                windowrulev2 = noanim,class:^(xwaylandvideobridge)$
                windowrulev2 = nofocus,class:^(xwaylandvideobridge)$
                windowrulev2 = noinitialfocus,class:^(xwaylandvideobridge)$
              '';
          };
        };
      };
    };
  }
