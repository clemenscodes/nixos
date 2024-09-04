{
  pkgs,
  config,
  osConfig,
  lib,
  ...
}: let
  cfg = config.modules.media.video;
  isDesktop = osConfig.modules.display.gui != "headless";
in
  with lib; {
    options = {
      modules = {
        media = {
          video = {
            obs = {
              enable = mkEnableOption "Enable OBS (open broadcast software)" // {default = cfg.enable && isDesktop;};
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.obs.enable && isDesktop) {
      programs = {
        obs-studio = {
          enable = cfg.obs.enable && isDesktop;
          plugins = with pkgs.obs-studio-plugins; [
            wlrobs
            input-overlay
            obs-pipewire-audio-capture
            obs-vkcapture
            obs-gstreamer
            obs-vaapi
          ];
        };
      };
    };
  }
