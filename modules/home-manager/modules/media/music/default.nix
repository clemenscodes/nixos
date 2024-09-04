{
  config,
  lib,
  ...
}: let
  cfg = config.modules.media;
in
  with lib; {
    imports = [
      ./dlplaylist
      ./ncmpcpp
      ./spotdl
      ./spotify
    ];
    options = {
      modules = {
        media = {
          music = {
            enable = mkEnableOption "Enable music" // {default = cfg.enable;};
          };
        };
      };
    };
  }
