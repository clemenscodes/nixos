{
  config,
  lib,
  ...
}: let
  cfg = config.modules.media;
in
  with lib; {
    imports = [
      ./stockfish
    ];
    options = {
      modules = {
        media = {
          games = {
            enable = mkEnableOption "Enable games" // {default = cfg.enable;};
          };
        };
      };
    };
  }
