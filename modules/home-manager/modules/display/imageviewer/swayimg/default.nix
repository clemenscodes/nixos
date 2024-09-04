{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.display.imageviewer;
in
  with lib; {
    options = {
      modules = {
        display = {
          imageviewer = {
            swayimg = {
              enable = mkEnableOption "Enable swayimg" // {default = cfg.enable;};
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.swayimg.enable) {
      home = {
        packages = with pkgs; [
          swayimg
        ];
      };
    };
  }
