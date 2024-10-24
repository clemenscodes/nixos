{
  pkgs,
  config,
  osConfig,
  lib,
  ...
}: let
  cfg = config.modules.media.communication;
  isDesktop = osConfig.modules.display.gui != "headless";
in
  with lib; {
    options = {
      modules = {
        media = {
          communication = {
            element = {
              enable = mkEnableOption "Enable element" // {default = cfg.enable && isDesktop;};
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.element.enable && isDesktop) {
      home = {
        packages = [pkgs.element-desktop-wayland];
      };
    };
  }
