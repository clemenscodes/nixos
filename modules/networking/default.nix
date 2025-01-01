{
  lib,
  config,
  ...
}: let
  cfg = config.modules;
  inherit (cfg.users) user;
in {
  imports = [
    ./bluetooth
    ./dbus
    ./dns
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
        enable = lib.mkEnableOption "Enable networking options" // {default = false;};
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.networking.enable) {
    networking = {
      hostName = config.modules.hostname.defaultHostname;
      networkmanager = {
        inherit (cfg.networking) enable;
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
