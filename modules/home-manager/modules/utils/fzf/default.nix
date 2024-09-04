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
        fzf = {
          enable = mkEnableOption "Enable fzf" // {default = cfg.enable;};
        };
      };
    };
  };
  config = mkIf (cfg.enable && cfg.fzf.enable) {
    programs = {
      fzf = {
        enable = cfg.fzf.enable;
        catppuccin = mkIf (osConfig.modules.themes.catppuccin.enable) {
          inherit (osConfig.modules.themes.catppuccin) enable flavor;
        };
      };
    };
  };
}
