{
  lib,
  config,
  ...
}: let
  cfg = config.modules;
in
  with lib; {
    imports = [
      ./gtk
      ./hyprland
      ./qt
      ./sddm
      ./uwsm
    ];
    options = {
      modules = {
        display = {
          enable = mkEnableOption "Enable display configuration" // {default = cfg.display.gui != "headless";};
          gui = mkOption {
            type = types.enum ["wayland" "headless"];
            default =
              if cfg.machine.kind == "desktop" || cfg.machine.kind == "laptop"
              then "wayland"
              else "headless";
          };
        };
      };
    };
  }
