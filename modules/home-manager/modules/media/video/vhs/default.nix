{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.media.video;
in
  with lib; {
    options = {
      modules = {
        media = {
          video = {
            vhs = {
              enable = mkEnableOption "Enable vhs to record terminal outputs" // {default = cfg.enable;};
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.vhs.enable) {
      home = {
        packages = with pkgs; [
          vhs
        ];
      };
    };
  }
