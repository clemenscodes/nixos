{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.storage;
in {
  options = {
    modules = {
      storage = {
        rclone = {
          enable = lib.mkEnableOption "Enable rclone for storage" // {default = false;};
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.rclone.enable) {
    home = {
      packages = [
        pkgs.rclone
        pkgs.rclone-browser
      ];
    };
  };
}
