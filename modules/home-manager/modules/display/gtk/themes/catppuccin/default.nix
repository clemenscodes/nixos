{
  config,
  osConfig,
  lib,
  ...
}: let
  cfg = config.modules.display.gtk.themes;
  isDesktop = osConfig.modules.display.gui != "headless";
in
  with lib; {
    options = {
      modules = {
        display = {
          gtk = {
            themes = {
              catppuccin = {
                # Deprecated, support will be removed
                enable = mkEnableOption "Enable GTK catppuccin theme" // {default = false;};
              };
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.catppuccin.enable && isDesktop) {
      gtk = {
        catppuccin = {
          inherit (osConfig.modules.themes.catppuccin) enable flavor;
        };
      };
    };
  }
