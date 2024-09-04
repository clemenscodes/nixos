{
  lib,
  config,
  osConfig,
  ...
}: let
  cfg = config.modules;
  osCfg = osConfig.modules;
in
  with lib; {
    options = {
      modules = {
        fonts = {
          enable = mkEnableOption "Enable fonts" // {default = osCfg.fonts.enable && cfg.enable;};
        };
      };
    };
    config = mkIf (osCfg.fonts.enable && cfg.enable && cfg.fonts.enable) {
      fonts = {
        fontconfig = {
          enable = cfg.fonts.enable;
        };
      };
    };
  }
