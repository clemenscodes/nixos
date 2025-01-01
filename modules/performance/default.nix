{
  inputs,
  pkgs,
  lib,
  ...
}: {config, ...}: let
  cfg = config.modules;
in {
  imports = [
    (import ./auto-cpufreq {inherit inputs pkgs lib;})
    (import ./power {inherit inputs pkgs lib;})
    (import ./thermald {inherit inputs pkgs lib;})
    (import ./tlp {inherit inputs pkgs lib;})
  ];
  options = {
    modules = {
      performance = {
        enable = lib.mkEnableOption "Enable performance tweaks" // {default = cfg.machine.kind == "laptop";};
      };
    };
  };
}
