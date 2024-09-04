{
  pkgs,
  lib,
  config,
  ...
}: let
  size = 12;
  font = "VictorMono";
  fonts = ["${font}" "Iosevka" "Meslo"];
  monospace = "${font} Nerd Font Mono";
  sansSerif = "${font} Nerd Font";
  serif = "${font} Nerd Font";
  cfg = config.modules;
in
  with lib; {
    options = {
      modules = {
        fonts = {
          enable = mkEnableOption "Enable fonts" // {default = cfg.display.gui != "headless";};
          defaultFont = mkOption {
            type = types.str;
            default = sansSerif;
          };
          size = mkOption {
            type = types.int;
            default = size;
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.fonts.enable) {
      fonts = {
        packages = with pkgs; [
          (nerdfonts.override {inherit fonts;})
        ];
        fontconfig = {
          enable = cfg.fonts.enable;
          defaultFonts = {
            monospace = ["${monospace}"];
            sansSerif = ["${sansSerif}"];
            serif = ["${serif}"];
          };
        };
        fontDir = {
          enable = cfg.fonts.enable;
        };
      };
    };
  }
