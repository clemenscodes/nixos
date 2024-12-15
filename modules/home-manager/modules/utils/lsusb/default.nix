{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.utils;
in {
  options = {
    modules = {
      utils = {
        lsusb = {
          enable = mkEnableOption "Enable lsusb" // {default = cfg.enable;};
        };
      };
    };
  };
  config = mkIf (cfg.enable && cfg.lsusb.enable) {
    home = {
      packages = [pkgs.usbutils];
    };
  };
}
