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
          inherit (cfg.hyprland) enable;
          xwayland = {
            inherit (cfg.hyprland) enable;
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
