{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.media.editing;
in
  with lib; {
    options = {
      modules = {
        media = {
          editing = {
            gstreamer = {
              enable = mkEnableOption "Enable gstreamer" // {default = cfg.enable;};
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.gimp.enable) {
      home = {
        packages = with pkgs.gst_all_1; [
          gstreamer
          gstreamermm
          gst-vaapi
          gst-plugins-base
          gst-plugins-ugly
          gst-plugins-good
          gst-plugins-bad
          gst-plugins-rs
          gst-libav
        ];
      };
    };
  }
