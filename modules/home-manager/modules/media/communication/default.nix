{
  config,
  lib,
  ...
}: let
  cfg = config.modules.media;
in
  with lib; {
    imports = [
      ./discord
      ./element
    ];
    options = {
      modules = {
        media = {
          communication = {
            enable = mkEnableOption "Enable communication" // {default = cfg.enable;};
          };
        };
      };
    };
  }
