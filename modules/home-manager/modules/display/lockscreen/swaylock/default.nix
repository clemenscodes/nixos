{
  pkgs,
  config,
  osConfig,
  lib,
  ...
}: let
  cfg = config.modules.display.lockscreen;
in
  with lib; {
    options = {
      modules = {
        display = {
          lockscreen = {
            swaylock = {
              enable = mkEnableOption "Enable swaylock" // {default = cfg.enable;};
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.swaylock.enable) {
      home = {
        packages = [(import ./lockout {inherit pkgs;})];
      };
      programs = {
        swaylock = {
          enable = cfg.swaylock.enable;
          package = pkgs.swaylock-effects;
          catppuccin = mkIf (osConfig.modules.themes.catppuccin.enable) {
            inherit (osConfig.modules.themes.catppuccin) enable flavor;
          };
          settings = let
            inside-color = "1d1f21";
            text-color = "81a2be";
            clear-color = "b5bd68";
          in
            mkIf (!osConfig.modules.themes.catppuccin.enable) {
              clock = true;
              ignore-empty-password = true;
              indicator-caps-lock = true;
              indicator-radius = 169;
              indicator-thickness = 20;
              line-uses-ring = true;
              fade-in = 5;
              grace = 5;
              grace-no-mouse = true;
              grace-no-touch = true;
              image = "${config.xdg.dataHome}/images/wallpaper/ring.jpeg";
              font = "${osConfig.modules.fonts.defaultFont}";
              effect-blur = "20x6";
              effect-vignette = "1:1";
              key-hl-color = "7aa6daaa";
              bs-hl-color = "d54e53aa";
              separator-color = "55555555";
              line-color = "${inside-color}";
              text-color = "${text-color}";
              text-clear-color = "${clear-color}";
              text-caps-lock-color = "f0c674";
              text-ver-color = "000000";
              text-wrong-color = "ff0000";
              inside-color = "${inside-color}55";
              inside-clear-color = "${inside-color}";
              inside-ver-color = "${inside-color}77";
              inside-wrong-color = "${inside-color}66";
              ring-color = "${text-color}55";
              ring-ver-color = "${text-color}";
              ring-clear-color = "${clear-color}55";
              ring-wrong-color = "cc6666";
            };
        };
      };
    };
  }
