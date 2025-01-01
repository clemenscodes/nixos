{
  pkgs,
  lib,
  ...
}: {config, ...}: let
  cfg = config.modules.performance;
in {
  options = {
    modules = {
      performance = {
        auto-cpufreq = {
          enable = lib.mkEnableOption "Enable auto-cpufreq" // {default = cfg.enable;};
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.auto-cpufreq.enable) {
    systemd = {
      packages = [pkgs.auto-cpufreq];
    };
    services = {
      auto-cpufreq = {
        inherit (cfg.auto-cpufreq) enable;
      };
    };
  };
}
