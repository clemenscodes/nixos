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
          zotero = {
            enable = mkEnableOption "Enable zotero" // {default = cfg.enable && isDesktop;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.zotero.enable && isDesktop) {
      home = {
        packages = with pkgs; [zotero];
      };
    };
  }
