{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.crypto;
  teamredminer = "${import ./bin {inherit pkgs;}}";
  miner = "teamredminer";
  log = "/var/log/${miner}/${miner}.log";
in
  with lib; {
    imports = [
      ./settings
    ];
    options = {
      modules = {
        crypto = {
          teamredminer = {
            enable = mkEnableOption "Enable teamredminer" // {default = false;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.teamredminer.enable) {
      modules = {
        shell = {
          ld = {
            enable = true;
          };
        };
      };
      environment = {
        systemPackages = [teamredminer];
      };
      users = {
        users = {
          "${miner}" = {
            isSystemUser = true;
            group = "${miner}";
            description = "${miner} user";
            createHome = true;
            home = "/var/lib/${miner}";
          };
        };
        groups = {
          "${miner}" = {};
        };
      };
      systemd = {
        services = with pkgs; {
          "${miner}" = with cfg.teamredminer.settings; {
            description = "${miner} daemon";
            after = ["lactd.service"];
            wantedBy = ["invalid.target"];
            environment = {
              NIX_LD = "${stdenv.cc.libc}/lib/ld-linux-x86-64.so.2";
              OCL_ICD_VENDORS = "${rocmPackages.clr.icd}/etc/OpenCL/vendors/";
              LD_LIBRARY_PATH = "/run/opengl-driver/lib:${pkgs.lib.makeLibraryPath [pkg-config systemd]}:''$LD_LIBRARY_PATH";
              GPU_MAX_ALLOC_PERCENT = "100";
              GPU_SINGLE_ALLOC_PERCENT = "100";
              GPU_MAX_HEAP_SIZE = "100";
              GPU_USE_SYNC_OBJECTS = "1";
            };
            serviceConfig = {
              User = "${miner}";
              Group = "${miner}";
              LogsDirectory = "${miner}";
              LogsDirectoryMode = "0710";
              Restart = "always";
              RestartSec = "10";
              ExecStart =
                /*
                bash
                */
                ''${teamredminer}/bin/${miner} -a ${algorithm} -o stratum+tcp://${pool} -u ${wallet} --log_file=${log} -p ${rig}'';
            };
          };
        };
      };
    };
  }
