{pkgs, ...}: let
  ravencoin = "ravencoin";
in
  with pkgs; {
    systemd = {
      services = with import ./config.nix; {
        "${ravencoin}" = {
          description = "${ravencoin} daemon";
          after = ["lactd.service"];
          wantedBy = ["invalid.target"];
          environment = {
            OCL_ICD_VENDORS = "${rocm-opencl-icd}/etc/OpenCL/vendors/";
            LD_LIBRARY_PATH = "/run/opengl-driver/lib:/run/opengl-driver-32/lib:''$LD_LIBRARY_PATH";
          };
          serviceConfig = {
            LogsDirectory = "${ravencoin}";
            LogsDirectoryMode = "0710";
            Restart = "always";
            RestartSec = "30";
            ExecStart =
              /*
              bash
              */
              ''${xmrig}/bin/xmrig --no-cpu --opencl -o ${pool} -u ${wallet} -p ${worker} -a kawpow -k -S'';
          };
        };
      };
    };
  }
