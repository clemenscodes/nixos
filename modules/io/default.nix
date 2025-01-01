{
  inputs,
  lib,
  ...
}: {config, ...}: let
  cfg = config.modules;
in {
  imports = [
    ./android
    ./printing
    ./sound
    ./udisks
    (import ./xremap {inherit inputs;})
  ];
  options = {
    modules = {
      io = {
        enable = lib.mkEnableOption "Enable IO" // {default = cfg.display.gui != "headless";};
      };
    };
  };
}
