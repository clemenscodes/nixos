{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.media.editing;
in
  with lib; {
    options = {
      modules = {
        media = {
          editing = {
            backgroundremover = {
              enable = mkEnableOption "Enable backgroundremover" // {default = cfg.enable;};
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.backgroundremover.enable) {
      home = {
        packages = with pkgs; [
          backgroundremover
        ];
      };
    };
  }
