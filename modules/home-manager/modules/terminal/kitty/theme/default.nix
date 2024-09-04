{
  config,
  osConfig,
  lib,
  ...
}: let
  cfg = config.modules.terminal;
in
  with lib; {
    config = mkIf (cfg.enable && cfg.kitty.enable && !osConfig.modules.themes.catppuccin.enable) {
      programs = {
        kitty = {
          settings = with osConfig.modules.themes.base; {
            selection_background = "#${base00}";
            background = "#${background}";
            foreground = "#${foreground}";
            cursor = "#${cursor}";
            color0 = "#${base00}";
            color1 = "#${base01}";
            color2 = "#${base02}";
            color3 = "#${base03}";
            color4 = "#${base04}";
            color5 = "#${base05}";
            color6 = "#${base06}";
            color8 = "#${base08}";
            color7 = "#${base07}";
            color9 = "#${base09}";
            color10 = "#${base0A}";
            color11 = "#${base0B}";
            color12 = "#${base0C}";
            color13 = "#${base0D}";
            color14 = "#${base0E}";
            color15 = "#${base0F}";
          };
        };
      };
    };
  }
