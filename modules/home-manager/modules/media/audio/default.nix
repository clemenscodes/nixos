{
  config,
  lib,
  ...
}: let
  cfg = config.modules.media;
in
  with lib; {
    imports = [
      ./audacity
      ./interfaces
    ];
    options = {
      modules = {
        media = {
          audio = {
            enable = mkEnableOption "Enable audio processing" // {default = cfg.enable;};
          };
        };
      };
    };
  }
