{
  pkgs,
  config,
  osConfig,
  lib,
  ...
}: let
  dlplaylist = pkgs.writeShellScriptBin "dlplaylist" ''
    playlist_url=$1
    dest=${
      if osConfig.modules.wsl.enable
      then "$WINMUSIC"
      else "$XDG_MUSIC_DIR"
    }
    ${pkgs.yt-dlp}/bin/yt-dlp  --yes-playlist -o "$dest/%(title)s.%(ext)s" -f 'bestaudio/best' --extract-audio --audio-format opus $playlist_url
  '';
  cfg = config.modules.media.music;
in
  with lib; {
    options = {
      modules = {
        media = {
          music = {
            dlplaylist = {
              enable = mkEnableOption "Enable dlplaylist script to download youtube playlists" // {default = cfg.enable;};
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.dlplaylist.enable) {
      home = {
        packages = [dlplaylist];
      };
    };
  }
