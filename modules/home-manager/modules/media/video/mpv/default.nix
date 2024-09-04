{
  pkgs,
  config,
  osConfig,
  lib,
  ...
}: let
  cfg = config.modules.media.video;
in
  with lib; {
    options = {
      modules = {
        media = {
          video = {
            mpv = {
              enable = mkEnableOption "Enable mpv" // {default = cfg.enable;};
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.mpv.enable) {
      programs = {
        mpv = with pkgs; {
          enable = cfg.enable;
          package = mpv.override {scripts = [mpvScripts.mpris];};
          bindings = {
            l = "seek 5";
            h = "seek -5";
            j = "seek -60";
            k = "seek 60";
            S = "cycle sub";
          };
          catppuccin = mkIf (osConfig.modules.themes.catppuccin.enable) {
            inherit (osConfig.modules.themes.catppuccin) enable flavor;
          };
        };
      };
    };
  }
