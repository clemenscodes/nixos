{
  config,
  lib,
  ...
}: let
  cfg = config.modules;
in
  with lib; {
    imports = [
      ./auto-cpufreq
      ./power
      ./thermald
      ./tlp
    ];
    options = {
      modules = {
        performance = {
          enable = mkEnableOption "Enable performance tweaks" // {default = cfg.machine.kind == "laptop";};
        };
      };
    };
  }
