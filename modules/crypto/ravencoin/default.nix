{
  inputs,
  pkgs,
  lib,
  ...
}: {config, ...}: let
  cfg = config.modules.crypto;
  ravencoin = "ravencoin";
in {
  imports = [
    (import ./settings {inherit inputs pkgs lib;})
  ];
  options = {
    modules = {
      crypto = {
        ravencoin = {
          enable = lib.mkEnableOption "Enable ravencoin" // {default = false;};
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.ravencoin.enable) {
    systemd = {
      services = with cfg.ravencoin.settings; {
        "${ravencoin}" = {
          description = "${ravencoin} daemon";
          after = ["lactd.service"];
          wantedBy = ["invalid.target"];
          environment = {
            OCL_ICD_VENDORS = "${pkgs.rocm.clr.icd}/etc/OpenCL/vendors/";
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
              ''${pkgs.xmrig}/bin/xmrig --no-cpu --opencl -o ${pool} -u ${wallet} -p ${worker} -a kawpow -k -S'';
          };
        };
      };
    };
  };
}
