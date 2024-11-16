{
  config,
  lib,
  ...
}: let
  cfg = config.modules;
  inherit (cfg.users) user;
  useHyprlock = config.home-manager.users.${user}.modules.display.lockscreen.hyprlock.enable;
in
  with lib; {
    options = {
      modules = {
        security = {
          hyprlock = {
            enable = mkEnableOption "Enable hyprlock PAM" // {default = useHyprlock;};
          };
        };
      };
    };
    config = mkIf cfg.security.hyprlock.enable {
      security = {
        pam = {
          services = {
            hyprlock = {};
          };
        };
      };
    };
  }
