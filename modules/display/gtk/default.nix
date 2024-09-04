{
  config,
  lib,
  ...
}: let
  cfg = config.modules.display;
in
  with lib; {
    options = {
      modules = {
        display = {
          gtk = {
            enable = mkEnableOption "Enable GTK" // {default = cfg.enable;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.gtk.enable) {
      gtk = {
        iconCache = {
          enable = cfg.gtk.enable;
        };
      };
    };
  }
