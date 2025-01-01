{lib, ...}: {config, ...}: let
  cfg = config.modules.networking;
in {
  options = {
    modules = {
      networking = {
        dbus = {
          enable = lib.mkEnableOption "Enable inter-process-communication via dbus" // {default = cfg.enable;};
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.dbus.enable) {
    services = {
      dbus = {
        enable = cfg.dbus.enable;
      };
    };
  };
}
