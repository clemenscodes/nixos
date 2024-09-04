{
  config,
  osConfig,
  lib,
  ...
}: let
  cfg = config.modules.monitoring;
in
  with lib; {
    options = {
      modules = {
        monitoring = {
          btop = {
            enable = mkEnableOption "Enable btop monitoring" // {default = cfg.enable;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.btop.enable) {
      programs = {
        btop = {
          enable = cfg.btop.enable;
          settings = {
            vim_keys = true;
          };
          catppuccin = mkIf (osConfig.modules.themes.catppuccin.enable) {
            inherit (osConfig.modules.themes.catppuccin) enable flavor;
          };
        };
      };
    };
  }
