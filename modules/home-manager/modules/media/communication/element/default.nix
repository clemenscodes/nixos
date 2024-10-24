{
  pkgs,
  config,
  osConfig,
  lib,
  ...
}: let
  cfg = config.modules.media.communication;
  isDesktop = osConfig.modules.display.gui != "headless";
  element = pkgs.element-desktop-wayland;
  elementIcon = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/element-hq/element-desktop/refs/heads/develop/res/img/element.png";
    sha256 = "sha256-FDq3fPk6imYMWxJJnJPH+gBAwBklv+DjHEc42mqmgoU=";
  };
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
        packages = [element];
      };
      xdg = {
        desktopEntries = {
          discord = {
            name = "Element";
            type = "Application";
            categories = ["Network" "InstantMessaging"];
            exec = "${element}/bin/element-desktop";
            genericName = "A feature-rich client for Matrix.org";
            icon = "${elementIcon}";
            mimeType = ["x-scheme-handler/element"];
          };
        };
      };
    };
  }
