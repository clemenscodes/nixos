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
        tldr = {
          enable = mkEnableOption "Enable tldr" // {default = cfg.enable;};
        };
      };
    };
  };
  config = mkIf (cfg.enable && cfg.tldr.enable) {
    home = {
      packages = with pkgs; [tldr];
    };
  };
}
