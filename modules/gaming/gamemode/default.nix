{
  lib,
  config,
  ...
}: let
  cfg = config.modules.gaming;
in
  with lib; {
    options = {
      modules = {
        gaming = {
          gamemode = {
            enable = mkEnableOption "Enable gamemode" // {default = cfg.enable;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.gamemode.enable) {
      programs = {
        gamemode = {
          enable = cfg.gamemode.enable;
        };
        settings = {
          general = {
            renice = 10;
          };
          gpu = {
            apply_gpu_optimisations = "accept-responsibility";
            gpu_device = 0;
            amd_performance_level = "high";
          };
          custom = {
            start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
            end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
          };
        };
      };
    };
  }
