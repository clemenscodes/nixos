{
  config,
  osConfig,
  lib,
  ...
}: let
  cfg = config.modules.development;
in
  with lib; {
    options = {
      modules = {
        development = {
          gitui = {
            enable = mkEnableOption "Enable gitui" // {default = cfg.enable;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.gitui.enable) {
      programs = {
        gitui = {
          enable = cfg.gitui.enable;
          catppuccin = mkIf (osConfig.modules.themes.catppuccin.enable) {
            inherit (osConfig.modules.themes.catppuccin) enable flavor;
          };
        };
      };
    };
  }
