{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.display;
  kvantum = pkgs.catppuccin-kvantum.override {
    accent = "blue";
    variant = "macchiato";
  };
in {
  options = {
    modules = {
      display = {
        qt = {
          enable = lib.mkEnableOption "Enable Qt" // {default = cfg.enable;};
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.qt.enable) {
    home = {
      packages = with pkgs; [
        libsForQt5.qtstyleplugin-kvantum
        libsForQt5.qt5ct
        libsForQt5.qt5.qtwayland
        catppuccin-qt5ct
        qt6.qtwayland
        kvantum
      ];
      sessionVariables = {
        QT_QPA_PLATFORM = "wayland;xcb";
        QT_QPA_PLATFORMTHEME = "kvantum";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        QT_AUTO_SCREEN_SCALE_FACTOR = "1";
        SDL_VIDEODRIVER = "wayland";
        GDK_BACKEND = "wayland,x11,*";
      };
    };
    qt = {
      enable = cfg.qt.enable;
      platformTheme = {
        name = "kvantum";
      };
      style = {
        name = "kvantum";
        package = kvantum;
      };
    };
  };
}
