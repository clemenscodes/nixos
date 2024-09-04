{
  lib,
  config,
  osConfig,
  ...
}: let
  cfg = config.modules;
  isDesktop = osConfig.modules.display.gui != "headless";
in
  with lib; {
    imports = [
      ./audio
      ./communication
      ./editing
      ./games
      ./music
      ./video
    ];
    options = {
      modules = {
        media = {
          enable = mkEnableOption "Enable media" // {default = cfg.enable && isDesktop;};
        };
      };
    };
  }
