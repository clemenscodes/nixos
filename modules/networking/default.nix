{
  lib,
  config,
  ...
}: let
  cfg = config.modules;
  user = cfg.users.user;
in
  with lib; {
    imports = [
      ./bluetooth
      ./dbus
      ./firewall
      ./irc
      ./mtr
      ./stevenblack
      ./torrent
      ./upnp
      ./vpn
      ./wireless
      ./wireshark
    ];
    options = {
      modules = {
        networking = {
          enable = mkEnableOption "Enable networking options" // {default = false;};
        };
      };
    };
    config = mkIf (cfg.enable && cfg.networking.enable) {
      networking = {
        hostName = config.modules.hostname.defaultHostname;
        networkmanager = {
          enable = cfg.networking.enable;
          unmanaged = [
            "*"
            "except:type:wwan"
            "except:type:wifi"
            "except:type:ethernet"
          ];
        };
      };
      users = {
        users = {
          ${user} = {
            extraGroups = ["networkmanager"];
          };
        };
      };
    };
  }
