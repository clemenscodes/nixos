{pkgs, ...}: let
  teamredminer = "${import ./teamredminer.nix {inherit pkgs;}}";
  miner = "teamredminer";
  log = "/var/log/${miner}/${miner}.log";
in {
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
  programs = {
    nix-ld = {
      enable = true;
    };
  };
  systemd = {
    services = with pkgs; {
      "${miner}" = with import ./config.nix; {
        description = "${miner} daemon";
        after = ["lactd.service"];
        wantedBy = ["invalid.target"];
        environment = {
          NIX_LD = "${stdenv.cc.libc}/lib/ld-linux-x86-64.so.2";
          OCL_ICD_VENDORS = "${rocm-opencl-icd}/etc/OpenCL/vendors/";
          LD_LIBRARY_PATH = "/run/opengl-driver/lib:/run/opengl-driver-32/lib:${pkgs.lib.makeLibraryPath [pkg-config systemd]}:''$LD_LIBRARY_PATH";
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
}
