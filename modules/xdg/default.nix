{
  pkgs,
  config,
  lib,
  ...
}:
with pkgs; let
  cfg = config.modules;
  waylandPkgs =
    if cfg.display.gui == "wayland"
    then [xdg-desktop-portal-wlr]
    else [];
in
  with lib; {
    options = {
      modules = {
        xdg = {
          enable = mkEnableOption "Enable XDG" // {default = cfg.enable;};
        };
      };
    };
    config = mkIf (cfg.enable && cfg.xdg.enable) {
      xdg = {
        autostart = {
          enable = cfg.xdg.enable;
        };
        portal = {
          enable = cfg.display.gui != "headless";
          extraPortals =
            waylandPkgs
            ++ [
              xdg-desktop-portal-gtk
              xdg-desktop-portal
            ];
          wlr = {
            enable = mkForce cfg.display.gui == "wayland";
          };
        };
      };
    };
  }
