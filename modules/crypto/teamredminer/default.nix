{
  inputs,
  pkgs,
  lib,
  ...
}: {config, ...}: let
  cfg = config.modules.crypto;
  teamredminer = "${import ./bin {inherit inputs pkgs lib;}}";
  miner = "teamredminer";
  log = "/var/log/${miner}/${miner}.log";
in {
  imports = [
    (import ./settings {inherit inputs pkgs lib;})
  ];
  options = {
    modules = {
      crypto = {
        teamredminer = {
          enable = lib.mkEnableOption "Enable teamredminer" // {default = false;};
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.teamredminer.enable) {
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
      services = {
        "${miner}" = with cfg.teamredminer.settings; {
          description = "${miner} daemon";
          after = ["lactd.service"];
          wantedBy = ["invalid.target"];
          environment = {
            NIX_LD = "${pkgs.stdenv.cc.libc}/lib/ld-linux-x86-64.so.2";
            OCL_ICD_VENDORS = "${pkgs.rocmPackages.clr.icd}/etc/OpenCL/vendors/";
            LD_LIBRARY_PATH = "/run/opengl-driver/lib:${lib.makeLibraryPath [pkg-config systemd]}:''$LD_LIBRARY_PATH";
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
              ''${pkgs.teamredminer}/bin/${miner} -a ${algorithm} -o stratum+tcp://${pool} -u ${wallet} --log_file=${log} -p ${rig}'';
          };
        };
      };
    };
  };
}
