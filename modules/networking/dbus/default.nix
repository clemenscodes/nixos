{
  config,
  lib,
  ...
}: let
  cfg = config.modules.networking;
in
  with lib; {
    options = {
      modules = {
        networking = {
          dbus = {
            enable = mkEnableOption "Enable inter-process-communication via dbus" // {default = cfg.enable;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.dbus.enable) {
      services = {
        dbus = {
          enable = cfg.dbus.enable;
        };
      };
    };
  }
