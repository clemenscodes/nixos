{
  inputs,
  pkgs,
  lib,
  ...
}: {config, ...}: let
  cfg = config.modules.crypto;
  mkUser = user: {
    isSystemUser = true;
    group = "${user}";
    description = "${user} user";
    createHome = true;
    home = "/var/lib/${user}";
  };
in {
  imports = [
    (import ./monerod {inherit inputs pkgs lib;})
    (import ./p2pool {inherit inputs pkgs lib;})
    (import ./settings {inherit inputs pkgs lib;})
    (import ./xmrig {inherit inputs pkgs lib;})
  ];
  options = {
    modules = {
      crypto = {
        monero = {
          enable = lib.mkEnableOption "Enable monero" // {default = false;};
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.monero.enable) {
    environment = {
      systemPackages = [pkgs.monero-gui];
    };
    users = with cfg.monero.settings; {
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
        allowedTCPPorts = with cfg.monero.settings; [
          p2pPort
          rpcPort
          p2poolPort
          p2poolMiniPort
          p2poolStratumPort
        ];
      };
    };
  };
}
