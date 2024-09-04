{
  config,
  lib,
  ...
}: let
  cfg = config.modules.shell;
in
  with lib; {
    options = {
      modules = {
        shell = {
          console = {
            enable = mkEnableOption "Enable a neat console configuration" // {default = cfg.enable;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.console.enable) {
      console = {
        earlySetup = cfg.console.enable;
        keyMap = config.modules.locale.defaultLocale;
        catppuccin = mkIf (config.modules.themes.catppuccin.enable) {
          inherit (config.modules.themes.catppuccin) enable flavor;
        };
      };
    };
  }
