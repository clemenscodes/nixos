{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.display;
  catppuccin = config.modules.themes.catppuccin;
in
  with lib; {
    options = {
      modules = {
        display = {
          sddm = {
            enable = mkEnableOption "Enable a swag sddm login manager" // {default = cfg.enable && cfg.hyprland.enable;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.hyprland.enable && cfg.sddm.enable) {
      environment = {
        systemPackages = with pkgs; [
          libsForQt5.qt5.qtquickcontrols2
          libsForQt5.qt5.qtsvg
          libsForQt5.qt5.qtgraphicaleffects
          catppuccin-cursors.macchiatoBlue
        ];
      };
      services = {
        xserver = {
          xkb = {
            layout = config.modules.locale.defaultLocale;
          };
        };
        displayManager = {
          defaultSession = "hyprland";
          sddm = {
            catppuccin = mkIf (catppuccin.enable) {
              inherit (catppuccin) enable flavor;
            };
            package = pkgs.kdePackages.sddm;
            enable = cfg.sddm.enable;
            enableHidpi = true;
            wayland = {
              enable = cfg.gui == "wayland";
            };
            theme = "catppuccin-macchiato";
            extraPackages = with pkgs.kdePackages; [
              breeze-icons
              kirigami
              plasma5support
              qtsvg
              qtvirtualkeyboard
            ];
            # theme = mkForce "${import ./themes/catppuccin-macchiato.nix {inherit pkgs;}}";
            settings = {
              Theme = mkForce {
                CursorTheme = "catppuccin-macchiato-blue-cursors";
              };
            };
          };
        };
      };
    };
  }
