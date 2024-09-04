{inputs}: {
  config,
  lib,
  ...
}: let
  cfg = config.modules;
in
  with lib; {
    imports = [
      ./printing
      ./sound
      ./udisks
      (import ./xremap {inherit inputs;})
    ];
    options = {
      modules = {
        io = {
          enable = mkEnableOption "Enable IO" // {default = cfg.display.gui != "headless";};
        };
      };
    };
  }
