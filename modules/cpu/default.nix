{
  config,
  lib,
  ...
}: let
  cfg = config.modules;
in
  with lib; {
    imports = [
      ./amd
      ./intel
    ];
    options = {
      modules = {
        cpu = {
          enable = mkEnableOption "Enable CPU configuration" // {default = cfg.enable;};
          vendor = mkOption {
            type = types.enum ["intel" "amd"];
            default = "intel";
          };
          msr = {
            enable = mkEnableOption "Enable MSR" // {default = cfg.enable;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.cpu.enable && cfg.cpu.msr.enable) {
      hardware = {
        cpu = {
          x86 = {
            msr = {
              enable = cfg.cpu.msr.enable;
            };
          };
        };
      };
    };
  }
