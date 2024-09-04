{
  config,
  lib,
  ...
}: let
  cfg = config.modules.display;
in
  with lib; {
    imports = [
      ./swayimg
    ];
    options = {
      modules = {
        display = {
          imageviewer = {
            enable = mkEnableOption "Enable image viewer" // {default = cfg.enable;};
            defaultImageViewer = mkOption {
              type = types.enum ["swayimg"];
              default = "swayimg";
            };
          };
        };
      };
    };
  }
