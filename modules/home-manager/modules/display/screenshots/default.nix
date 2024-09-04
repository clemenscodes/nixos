{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.display;
in
  with lib; {
    options = {
      modules = {
        display = {
          screenshots = {
            enable = mkEnableOption "Enable screenshots" // {default = cfg.enable;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.screenshots.enable) {
      home = {
        packages = with pkgs; [
          grim
          slurp
          swappy
          (import ./screenshot {inherit pkgs;})
          (import ./fullscreenshot {inherit pkgs;})
        ];
      };
      xdg = {
        configFile = {
          "swappy/config" = {
            text = ''
              [Default]
              save_dir=${config.xdg.dataHome}/images/screenshots
            '';
          };
        };
      };
    };
  }
