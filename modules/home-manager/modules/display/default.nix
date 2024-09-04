{inputs}: {
  lib,
  config,
  osConfig,
  ...
}: let
  cfg = config.modules;
in
  with lib; {
    imports = [
      ./bar
      (import ./compositor {inherit inputs;})
      ./cursor
      ./gtk
      ./imageviewer
      ./launcher
      ./lockscreen
      ./notifications
      ./pdfviewer
      ./qt
      ./screenshots
      ./vnc
    ];
    options = {
      modules = {
        display = {
          enable = mkEnableOption "Enable a slick display configuration" // {default = cfg.enable && osConfig.modules.display.enable;};
        };
      };
    };
  }
