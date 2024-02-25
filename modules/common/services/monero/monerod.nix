{pkgs, ...}: {
  systemd = {
    services = with import ./config.nix; {
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
