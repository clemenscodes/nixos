{
  config,
  lib,
  ...
}: let
  cfg = config.modules;
  inherit (cfg.users) user;
  useSwaylock = config.home-manager.users.${user}.modules.display.lockscreen.swaylock.enable;
in
  with lib; {
    options = {
      modules = {
        security = {
          swaylock = {
            enable = mkEnableOption "Enable swaylock PAM" // {default = useSwaylock;};
          };
        };
      };
    };
    config = mkIf cfg.security.swaylock.enable {
      security = {
        pam = {
          services = {
            swaylock = {};
          };
        };
      };
    };
  }
