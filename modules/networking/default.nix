{
  inputs,
  pkgs,
  lib,
  ...
}: {config, ...}: let
  cfg = config.modules;
  inherit (cfg.users) user;
in {
  imports = [
    (import ./bluetooth {inherit inputs pkgs lib;})
    (import ./dbus {inherit inputs pkgs lib;})
    (import ./dns {inherit inputs pkgs lib;})
    (import ./firewall {inherit inputs pkgs lib;})
    (import ./irc {inherit inputs pkgs lib;})
    (import ./mtr {inherit inputs pkgs lib;})
    (import ./stevenblack {inherit inputs pkgs lib;})
    (import ./torrent {inherit inputs pkgs lib;})
    (import ./upnp {inherit inputs pkgs lib;})
    (import ./vpn {inherit inputs pkgs lib;})
    (import ./wireless {inherit inputs pkgs lib;})
    (import ./wireshark {inherit inputs pkgs lib;})
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
