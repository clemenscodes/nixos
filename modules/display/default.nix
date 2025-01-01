{
  lib,
  config,
  ...
}: let
  cfg = config.modules;
in {
  imports = [
    ./gtk
    ./hyprland
    ./qt
    ./sddm
  ];
  options = {
    modules = {
      display = {
        enable = lib.mkEnableOption "Enable display configuration" // {default = cfg.display.gui != "headless";};
        gui = lib.mkOption {
          type = lib.types.enum ["wayland" "headless"];
          default =
            if cfg.machine.kind == "desktop" || cfg.machine.kind == "laptop"
            then "wayland"
            else "headless";
        };
      };
    };
  };
}
