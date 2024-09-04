{
  config,
  osConfig,
  lib,
  ...
}: let
  cfg = config.modules.development.gh.plugins;
in
  with lib; {
    options = {
      modules = {
        development = {
          gh = {
            plugins = {
              gh-dash = {
                enable = mkEnableOption "Enable the GitHub CLI dashboard plugin" // {default = cfg.enable;};
              };
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.gh-dash.enable) {
      programs = {
        gh-dash = {
          enable = cfg.gh-dash.enable;
          catppuccin = mkIf (osConfig.modules.themes.catppuccin.enable) {
            inherit (osConfig.modules.themes.catppuccin) enable flavor;
          };
        };
      };
    };
  }
