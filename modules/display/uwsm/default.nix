{
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
          uwsm = {
            enable = mkEnableOption "Enable the universal wayland session manager" // {default = cfg.enable && cfg.gui == "wayland";};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.uwsm.enable) {
      programs = {
        uwsm = {
          inherit (cfg.uwsm) enable;
          waylandCompositors = {
            hyprland = mkIf (cfg.hyprland.enable) {
              binPath = "/run/current-system/sw/bin/Hyprland";
              comment = "Hyprland session managed by uwsm";
              prettyName = "Hyprland";
            };
          };
        };
      };
    };
  }
