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
          lazygit = {
            enable = mkEnableOption "Enable lazygit" // {default = cfg.enable;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.lazygit.enable) {
      programs = {
        lazygit = {
          enable = cfg.lazygit.enable;
          catppuccin = mkIf (osConfig.modules.themes.catppuccin.enable) {
            inherit (osConfig.modules.themes.catppuccin) enable flavor;
          };
        };
      };
    };
  }
