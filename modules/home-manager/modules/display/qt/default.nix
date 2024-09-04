{
  pkgs,
  config,
  osConfig,
  lib,
  ...
}: let
  cfg = config.modules.display;
in
  with lib; {
    options = {
      modules = {
        display = {
          qt = {
            enable = mkEnableOption "Enable Qt" // {default = cfg.enable;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.qt.enable) {
      home = {
        packages = with pkgs; [
          # (catppuccin-kvantum.override {
          #   accent = "Blue";
          #   variant = "Macchiato";
          # })
          # libsForQt5.qtstyleplugin-kvantum
          # libsForQt5.qt5ct
          # libsForQt5.qt5.qtwayland
          # catppuccin-qt5ct
          # catppuccin-kvantum
          # qt6.qtwayland
        ];
        sessionVariables = {
          QT_QPA_PLATFORM = "wayland";
          # QT_QPA_PLATFORMTHEME = "kvantum";
          # QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
          # QT_AUTO_SCREEN_SCALE_FACTOR = "1";
        };
      };
      qt = {
        enable = cfg.qt.enable;
        # platformTheme = {
        #   name = "kvantum";
        # };
        style = {
          # name = "kvantum";
          # package = pkgs.catppuccin-kvantum;
          catppuccin = mkIf (osConfig.modules.themes.catppuccin.enable) {
            # inherit (osConfig.modules.themes.catppuccin) enable flavor;
            enable = false;
          };
        };
      };
    };
  }
