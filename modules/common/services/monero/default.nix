{pkgs, ...}: let
  mkUser = user: {
    isSystemUser = true;
    group = "${user}";
    description = "${user} user";
    createHome = true;
    home = "/var/lib/${user}";
  };
  p2pPort = 18080;
  restrictedRpcPort = 18089;
  p2poolPort = 37889;
  p2poolStratumPort = 3333;
  zmqPort = 18084;
  monero = "monero";
  xmrig = "xmrig";
  p2pool = "p2pool";
  host = "127.0.0.1";
in {
  environment = {
    systemPackages = [
      pkgs.monero-gui
      pkgs.p2pool
      pkgs.xmrig
    ];
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
  systemd = {
    services = {
      "${monero}" = let
        logsDirectory = "/var/log/${monero}";
        stateDirectory = "/var/lib/${monero}";
        rateLimit = 128000;
        configFile = pkgs.writeText "monero.conf" ''
          data-dir=${stateDirectory}/.bitmonero
          zmq-pub=tcp://${host}:${builtins.toString zmqPort}
          log-file=${logsDirectory}/monerod.log
          p2p-bind-ip=${host}
          p2p-bind-port=${builtins.toString p2pPort}
          rpc-restricted-bind-ip=${host}
          rpc-restricted-bind-port=${builtins.toString restrictedRpcPort}
          no-igd=1
          enable-dns-blocklist=1
          out-peers=50
          in-peers=50
          disable-dns-checkpoints=1
          limit-rate-up=${builtins.toString rateLimit}
          limit-rate-down=${builtins.toString rateLimit}
        '';
      in {
        description = "${monero} daemon";
        after = ["network.target"];
        wantedBy = ["multi-user.target"];
        serviceConfig = {
          User = "${monero}";
          Group = "${monero}";
          LogsDirectory = "${monero}";
          LogsDirectoryMode = "0710";
          Restart = "always";
          RestartSec = 30;
          SuccessExitStatus = [0 1];
          ExecStart =
            /*
            bash
            */
            ''${pkgs.monero-cli}/bin/monerod --config-file=${configFile} --non-interactive'';
        };
      };
    };
  };
}
