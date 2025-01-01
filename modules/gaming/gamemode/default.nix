{
  pkgs,
  lib,
  ...
}: {config, ...}: let
  cfg = config.modules.gaming;
in {
  options = {
    modules = {
      gaming = {
        gamemode = {
          enable = lib.mkEnableOption "Enable gamemode" // {default = cfg.enable;};
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.gamemode.enable) {
    programs = {
      gamemode = {
        inherit (cfg.gamemode) enable;
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
  };
}
