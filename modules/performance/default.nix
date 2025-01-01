{
  config,
  lib,
  ...
}: let
  cfg = config.modules;
in {
  imports = [
    ./auto-cpufreq
    ./power
    ./thermald
    ./tlp
  ];
  options = {
    modules = {
      performance = {
        enable = lib.mkEnableOption "Enable performance tweaks" // {default = cfg.machine.kind == "laptop";};
      };
    };
  };
}
