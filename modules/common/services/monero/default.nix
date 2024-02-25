{pkgs, ...}: let
  mkUser = user: {
    isSystemUser = true;
    group = "${user}";
    description = "${user} user";
    createHome = true;
    home = "/var/lib/${user}";
  };
in
  with import ./config.nix; {
    imports = [
      ./monerod.nix
      ./p2pool.nix
      ./xmrig.nix
    ];
    environment = {
      systemPackages = with pkgs; [
        monero-gui
      ];
    };
    users = {
      users = {
        "${monero}" = mkUser monero;
        "${xmrig}" = mkUser xmrig;
        "${p2pool}" = mkUser p2pool;
      };
      groups = {
        "${monero}" = {};
        "${xmrig}" = {};
        "${p2pool}" = {};
      };
    };
    boot = {
      kernel = {
        sysctl = {
          "vm.nr_hugepages" = 3072;
        };
      };
    };
    networking = {
      firewall = {
        allowedTCPPorts = [p2pPort restrictedRpcPort p2poolPort p2poolStratumPort];
      };
    };
  }
