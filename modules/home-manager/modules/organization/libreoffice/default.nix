{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}: let
  cfg = config.modules.organization;
  isDesktop = osConfig.modules.display.gui != "headless";
in
  with lib; {
    options = {
      modules = {
        organization = {
          libreoffice = {
            enable = mkEnableOption "Enable libreoffice" // {default = cfg.enable && isDesktop;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.libreoffice.enable && isDesktop) {
      home = {
        packages = with pkgs; [libreoffice];
      };
    };
  }
