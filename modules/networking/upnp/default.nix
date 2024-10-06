{
  lib,
  config,
  ...
}: let
  cfg = config.modules.networking;
in
  with lib; {
    options = {
      modules = {
        networking = {
          upnp = {
            enable = mkEnableOption "Enable UPnP support using miniupnpd" // {default = false;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.upnp.enable) {
      services = {
        miniupnpd = {
          inherit (cfg.upnp) enable;
          upnp = cfg.upnp.enable;
        };
      };
    };
  }
