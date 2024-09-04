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
        unzip = {
          enable = mkEnableOption "Enable unzip" // {default = cfg.enable;};
        };
      };
    };
  };
  config = mkIf (cfg.enable && cfg.unzip.enable) {
    home = {
      packages = with pkgs; [unzip];
    };
  };
}
