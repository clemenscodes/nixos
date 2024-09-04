{
  lib,
  config,
  osConfig,
  ...
}:
with lib; let
  cfg = config.modules.utils;
in {
  options = {
    modules = {
      utils = {
        bat = {
          enable = mkEnableOption "Enable bat" // {default = cfg.enable;};
        };
      };
    };
  };
  config = mkIf (cfg.enable && cfg.bat.enable) {
    programs = {
      bat = {
        enable = cfg.bat.enable;
        catppuccin = mkIf (osConfig.modules.themes.catppuccin.enable) {
          inherit (osConfig.modules.themes.catppuccin) enable flavor;
        };
      };
    };
  };
}
