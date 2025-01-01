{
  pkgs,
  lib,
  ...
}: {config, ...}: let
  size = 8;
  font = "VictorMono";
  monospace = "${font} Nerd Font Mono";
  sansSerif = "${font} Nerd Font";
  serif = "${font} Nerd Font";
  cfg = config.modules;
in {
  options = {
    modules = {
      fonts = {
        enable = lib.mkEnableOption "Enable fonts" // {default = cfg.display.gui != "headless";};
        defaultFont = lib.mkOption {
          type = lib.types.str;
          default = sansSerif;
        };
        size = lib.mkOption {
          type = lib.types.int;
          default = size;
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.fonts.enable) {
    fonts = {
      packages = with pkgs.nerd-fonts; [
        iosevka
        victor-mono
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
