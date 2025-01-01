{
  pkgs,
  lib,
  ...
}: {config, ...}: let
  cfg = config.modules.io;
  isDesktop = config.modules.display.gui != "headless";
in {
  options = {
    modules = {
      io = {
        udisks = {
          enable = lib.mkEnableOption "Enable udisks service to automatically mount usb devices" // {default = cfg.enable;};
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.udisks.enable) {
    services = {
      udisks2 = {
        enable = cfg.udisks.enable;
      };
    };
    home-manager = lib.mkIf (config.modules.home-manager.enable && isDesktop) {
      users = {
        ${config.modules.users.user} = {
          home = {
            packages = with pkgs; [
              udiskie
            ];
          };
          services = {
            udiskie = {
              enable = cfg.udisks.enable;
              tray = "auto";
            };
          };
        };
      };
    };
  };
}
