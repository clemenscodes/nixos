{pkgs}:
pkgs.writeShellScriptBin "dlplaylist" ''
  playlist_url=$1
  ${pkgs.yt-dlp}/bin/yt-dlp  --yes-playlist -o '$XDG_MUSIC_DIR/%(title)s.%(ext)s' -f 'bestaudio/best' --extract-audio --audio-format opus $playlist_url
''
