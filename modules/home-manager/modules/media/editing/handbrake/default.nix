{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.media.editing;
in
  with pkgs;
  with lib; {
    options = {
      modules = {
        media = {
          editing = {
            handbrake = {
              enable = mkEnableOption "Enable handbrake" // {default = cfg.enable;};
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.handbrake.enable) {
      home = {
        packages = with pkgs; [handbrake];
      };
    };
  }
