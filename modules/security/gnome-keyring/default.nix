{
  config,
  lib,
  ...
}: let
  cfg = config.modules.security;
  isDesktop = config.modules.display.gui != "headless";
in
  with lib; {
    options = {
      modules = {
        security = {
          gnome-keyring = {
            enable = mkEnableOption "Enable gnome-keyring" // {default = cfg.enable && isDesktop;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.gnome-keyring.enable) {
      services = {
        gnome = {
          gnome-keyring = {
            inherit (cfg.gnome-keyring) enable;
          };
        };
      };
    };
  }
