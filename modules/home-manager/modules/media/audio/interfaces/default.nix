{
  config,
  lib,
  ...
}: let
  cfg = config.modules.media.audio;
in
  with lib; {
    imports = [./scarlett];
    options = {
      modules = {
        media = {
          audio = {
            interfaces = {
              enable = mkEnableOption "Enable audio interfaces" // {default = cfg.enable;};
            };
          };
        };
      };
    };
  }
