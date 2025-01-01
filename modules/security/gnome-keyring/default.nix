{lib, ...}: {config, ...}: let
  cfg = config.modules.security;
  isDesktop = config.modules.display.gui != "headless";
in {
  options = {
    modules = {
      security = {
        gnome-keyring = {
          enable = lib.mkEnableOption "Enable gnome-keyring" // {default = cfg.enable && isDesktop;};
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.gnome-keyring.enable) {
    services = {
      gnome = {
        gnome-keyring = {
          inherit (cfg.gnome-keyring) enable;
        };
      };
    };
  };
}
