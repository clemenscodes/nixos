{pkgs, ...}: let
  nanominer = "${import ./nanominer.nix {inherit pkgs;}}";
  miner = "nanominer";
  log = "/var/log/${miner}/${miner}.log";
in {
  environment = {
    systemPackages = [nanominer];
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
      "${miner}" = with import ./config.nix; let
        configFile = writeText "config.cfg" ''
          coin=${coin}
          pool1=${pool}
          wallet=${wallet}
          rigName=${rig}
          email=${email}
          logPath=${log}
          mport=${ethmanPort}
        '';
      in {
        description = "${miner} daemon";
        after = ["lactd.service"];
        wantedBy = ["invalid.target"];
        environment = {
          NIX_LD = "${stdenv.cc.libc}/lib/ld-linux-x86-64.so.2";
          OCL_ICD_VENDORS = "${rocm-opencl-icd}/etc/OpenCL/vendors/";
          LD_LIBRARY_PATH = "/run/opengl-driver/lib:/run/opengl-driver-32/lib:''$LD_LIBRARY_PATH";
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
            ''${nanominer}/bin/${miner} ${configFile}'';
        };
      };
    };
  };
}
