{
  inputs,
  pkgs,
  lib,
  ...
}: {config, ...}: let
  cfg = config.modules;
in {
  imports = [
    (import ./gtk {inherit inputs pkgs lib;})
    (import ./hyprland {inherit inputs pkgs lib;})
    (import ./qt {inherit inputs pkgs lib;})
    (import ./sddm {inherit inputs pkgs lib;})
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
