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
            swayidle = {
              enable = mkEnableOption "Enable swayidle" // {default = false;};
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.swayidle.enable) {
      home = {
        packages = with pkgs; [
          swayidle
          (import ./detectidle {inherit pkgs;})
        ];
      };
    };
  }
