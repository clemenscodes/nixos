{lib, ...}: {config, ...}: let
  cfg = config.modules;
  inherit (cfg.users) user;
  useHyprlock = config.home-manager.users.${user}.modules.display.lockscreen.hyprlock.enable;
in {
  options = {
    modules = {
      security = {
        hyprlock = {
          enable = lib.mkEnableOption "Enable hyprlock PAM" // {default = useHyprlock;};
        };
      };
    };
  };
  config = lib.mkIf cfg.security.hyprlock.enable {
    security = {
      pam = {
        services = {
          hyprlock = {};
        };
      };
    };
  };
}
