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
          hyprland = {
            enable = mkEnableOption "Enable anime titties" // {default = cfg.enable && cfg.gui == "wayland";};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.hyprland.enable) {
      programs = {
        hyprland = {
          enable = cfg.hyprland.enable;
          xwayland = {
            enable = true;
          };
        };
      };
      environment = {
        sessionVariables = {
          WLR_NO_HARDWARE_CURSORS = "1";
        };
      };
    };
  }
