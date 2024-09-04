{
  config,
  lib,
  ...
}: let
  cfg = config.modules.display.gtk;
in
  with lib; {
    imports = [
      ./catppuccin
    ];
    options = {
      modules = {
        display = {
          gtk = {
            themes = {
              enable = mkEnableOption "Enable GTK themes" // {default = cfg.enable;};
            };
          };
        };
      };
    };
  }
