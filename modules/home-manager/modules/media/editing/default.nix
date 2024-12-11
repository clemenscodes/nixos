{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.media;
in
  with lib; {
    imports = [
      ./backgroundremover
      ./davinci
      ./gimp
      ./gstreamer
      ./handbrake
      ./kdenlive
    ];
    options = {
      modules = {
        media = {
          editing = {
            enable = mkEnableOption "Enable editing modules" // {default = cfg.enable;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.editing.enable) {
      home = {
        packages = with pkgs; [ffmpeg x264 x265];
      };
    };
  }
