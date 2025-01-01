{
  inputs,
  pkgs,
  lib,
  ...
}: {config, ...}: let
  cfg = config.modules;
in {
  imports = [
    (import ./amd {inherit inputs pkgs lib;})
    (import ./intel {inherit inputs pkgs lib;})
  ];
  options = {
    modules = {
      cpu = {
        enable = lib.mkEnableOption "Enable CPU configuration" // {default = cfg.enable;};
        vendor = lib.mkOption {
          type = lib.types.enum ["intel" "amd"];
          default = "intel";
        };
        msr = {
          enable = lib.mkEnableOption "Enable MSR" // {default = cfg.enable;};
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.cpu.enable && cfg.cpu.msr.enable) {
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
