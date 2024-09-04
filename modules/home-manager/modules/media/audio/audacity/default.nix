{
  pkgs,
  config,
  osConfig,
  lib,
  ...
}: let
  cfg = config.modules.media.audio;
  isDesktop = osConfig.modules.display.gui != "headless";
in
  with lib; {
    options = {
      modules = {
        media = {
          audio = {
            audacity = {
              enable = mkEnableOption "Enable audacity" // {default = cfg.enable && isDesktop;};
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.audacity.enable && isDesktop) {
      home = {
        packages = with pkgs; [audacity];
      };
    };
  }
