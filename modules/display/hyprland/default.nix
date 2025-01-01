{lib, ...}: {config, ...}: let
  cfg = config.modules.display;
in {
  options = {
    modules = {
      display = {
        hyprland = {
          enable = lib.mkEnableOption "Enable anime titties" // {default = cfg.enable && cfg.gui == "wayland";};
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.hyprland.enable) {
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
