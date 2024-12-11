{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.utils;
in {
  options = {
    modules = {
      utils = {
        zip = {
          enable = mkEnableOption "Enable zip" // {default = cfg.enable;};
        };
      };
    };
  };
  config = mkIf (cfg.enable && cfg.zip.enable) {
    home = {
      packages = with pkgs; [zip];
    };
  };
}
