{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.crypto;
in
  with lib; {
    config = mkIf (cfg.enable && cfg.monero.enable) {
      modules = {
        cpu = {
          msr = {
            enable = true;
          };
        };
      };
      systemd = {
        services = with cfg.monero.settings; {
          "${xmrig}" = let
            dependencies = ["network-online.target" "systemd-modules-load.service" "${p2pool}.service" "${monero}.service"];
          in {
            description = "${xmrig} daemon";
            after = dependencies;
            wants = dependencies;
            wantedBy = ["multi-user.target"];
            serviceConfig = {
              LogsDirectory = "${xmrig}";
              LogsDirectoryMode = "0710";
              Restart = "always";
              RestartSec = "30";
              ExecStart =
                /*
                bash
                */
                ''${pkgs.xmrig}/bin/xmrig -o ${host}:${builtins.toString p2poolStratumPort} --coin monero -u ${wallet} --http-host ${host} -k --api-worker-id ${xmrig} --http-port ${builtins.toString p2poolStratumApiPort} --randomx-1gb-pages -S'';
            };
          };
        };
      };
    };
  }
