{
  pkgs,
  lib,
  ...
}: {config, ...}: let
  cfg = config.modules;
  waylandPkgs =
    if cfg.display.gui == "wayland"
    then [pkgs.xdg-desktop-portal-wlr]
    else [];
in {
  options = {
    modules = {
      xdg = {
        enable = lib.mkEnableOption "Enable XDG" // {default = cfg.enable;};
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.xdg.enable) {
    xdg = {
      autostart = {
        inherit (cfg.xdg) enable;
      };
      portal = {
        enable = cfg.display.gui != "headless";
        extraPortals =
          waylandPkgs
          ++ [
            pkgs.xdg-desktop-portal-gtk
            pkgs.xdg-desktop-portal
          ];
        wlr = {
          enable = lib.mkForce cfg.display.gui == "wayland";
        };
      };
    };
  };
}
