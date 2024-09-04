{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.modules.media.games;
in
  with lib; {
    options = {
      modules = {
        media = {
          games = {
            stockfish = {
              enable = mkEnableOption "Enable stockfish engine" // {default = cfg.enable;};
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.stockfish.enable) {
      home = {
        packages = with pkgs; [
          stockfish
        ];
      };
    };
  }
