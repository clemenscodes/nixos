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
            kdenlive = {
              enable = mkEnableOption "Enable kdenlive" // {default = cfg.enable;};
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.gimp.enable) {
      home = {
        packages = with pkgs; [
          glaxnimate
          kdenlive
        ];
      };
    };
  }
