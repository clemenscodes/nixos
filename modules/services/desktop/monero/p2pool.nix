{pkgs, ...}: {
  systemd = with import ./config.nix; let
    runtimeDirectory = "/var/run/${p2pool}";
    stateDirectory = "/var/lib/${p2pool}";
  in {
    sockets = {
      "${p2pool}" = {
        description = "${p2pool} socket";
        socketConfig = {
          ListenFIFO = "${runtimeDirectory}/${p2pool}.control";
          SocketUser = "${p2pool}";
          SocketGroup = "${p2pool}";
          SocketMode = "0666";
          DirectoryMode = "0755";
          RemoveOnStop = true;
        };
      };
    };
    services = {
      "${p2pool}" = let
        dependencies = ["network-online.target" "systemd-modules-load.service" "${monero}.service"];
      in {
        description = "${p2pool} daemon";
        after = dependencies;
        wants = dependencies;
        wantedBy = ["multi-user.target"];
        requires = ["${p2pool}.socket"];
        serviceConfig = {
          User = "${p2pool}";
          Group = "${p2pool}";
          WorkingDirectory = "${stateDirectory}";
          StandardInput = "socket";
          StandardOutput = "journal";
          StandardError = "journal";
          TimeoutStopSec = "60";
          ExecStart =
            /*
            bash
            */
            ''${pkgs.p2pool}/bin/p2pool --wallet ${wallet} --host ${host} --zmq-port ${builtins.toString zmqPort} --rpc-port ${builtins.toString rpcPort} --p2p ${host}:${builtins.toString p2poolMiniPort} --stratum ${host}:${builtins.toString p2poolStratumPort} --loglevel ${builtins.toString loglevel} --data-api ${stateDirectory} --stratum-api --mini'';
        };
      };
    };
  };
}
