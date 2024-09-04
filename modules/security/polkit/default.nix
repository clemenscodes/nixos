{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.security;
  isDesktop = config.modules.display.gui != "headless";
  polkitagent = import ./polkitagent {inherit pkgs;};
in
  with lib; {
    options = {
      modules = {
        security = {
          polkit = {
            enable = mkEnableOption "Enable policy kit" // {default = cfg.enable && isDesktop;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.polkit.enable && isDesktop) {
      environment = {
        systemPackages = [polkitagent];
      };
      security = {
        polkit = {
          inherit (cfg.polkit) enable;
        };
      };
    };
  }
