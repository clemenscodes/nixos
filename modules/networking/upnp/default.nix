{lib, ...}: {config, ...}: let
  cfg = config.modules.networking;
in {
  options = {
    modules = {
      networking = {
        upnp = {
          enable = lib.mkEnableOption "Enable UPnP support using miniupnpd" // {default = false;};
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.upnp.enable) {
    services = {
      miniupnpd = {
        inherit (cfg.upnp) enable;
        upnp = cfg.upnp.enable;
      };
    };
  };
}
