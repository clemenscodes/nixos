{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.display.lockscreen;
in
  with lib; {
    options = {
      modules = {
        display = {
          lockscreen = {
            sway-audio-idle-inhibit = {
              enable = mkEnableOption "Enable sway-audio-idle-inhibit" // {default = cfg.enable;};
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.sway-audio-idle-inhibit.enable) {
      home = {
        packages = [pkgs.sway-audio-idle-inhibit];
      };
    };
  }
