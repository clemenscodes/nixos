{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.performance;
in
  with lib; {
    options = {
      modules = {
        performance = {
          auto-cpufreq = {
            enable = mkEnableOption "Enable auto-cpufreq" // {default = cfg.enable;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.auto-cpufreq.enable) {
      systemd = {
        packages = with pkgs; [
          auto-cpufreq
        ];
      };
      services = {
        auto-cpufreq = {
          enable = cfg.auto-cpufreq.enable;
        };
      };
    };
  }
