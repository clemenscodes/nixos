{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.crypto;
  ravencoin = "ravencoin";
in
  with pkgs;
  with lib; {
    imports = [
      ./settings
    ];
    options = {
      modules = {
        crypto = {
          ravencoin = {
            enable = mkEnableOption "Enable ravencoin" // {default = false;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.ravencoin.enable) {
      systemd = {
        services = with cfg.ravencoin.settings; {
          "${ravencoin}" = {
            description = "${ravencoin} daemon";
            after = ["lactd.service"];
            wantedBy = ["invalid.target"];
            environment = {
              OCL_ICD_VENDORS = "${rocm-opencl-icd}/etc/OpenCL/vendors/";
              LD_LIBRARY_PATH = "/run/opengl-driver/lib:''$LD_LIBRARY_PATH";
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
    };
  }
