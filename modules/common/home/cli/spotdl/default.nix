{
  pkgs,
  config,
  ...
}: let
  # spotdl v4.1.8 is latest version that is not broken
  spotdl =
    (import (builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/9957cd48326fe8dbd52fdc50dd2502307f188b0d.tar.gz";
      sha256 = "1l2hq1n1jl2l64fdcpq3jrfphaz10sd1cpsax3xdya0xgsncgcsi";
    }) {inherit (pkgs) system;})
    .spotdl;
in {
  home = {
    packages = [
      spotdl
    ];
  };
  programs = {
    yt-dlp = {
      enable = true;
    };
  };
  xdg = {
    dataFile = {
      "spotdl/config.json" = {
        text = ''
          {
            "client_id": "5f573c9620494bae87890c0f08a60293",
            "client_secret": "212476d9b0f3472eaa762d90b19b0ba8",
            "auth_token": null,
            "user_auth": false,
            "headless": false,
            "cache_path": "${config.xdg.dataHome}/spotdl/.spotipy",
            "no_cache": false,
            "max_retries": 3,
            "use_cache_file": false,
            "audio_providers": [
                "youtube-music"
            ],
            "lyrics_providers": [
                "genius",
                "azlyrics",
                "musixmatch"
            ],
            "playlist_numbering": false,
            "scan_for_songs": false,
            "m3u": null,
            "output": "${config.xdg.userDirs.music}/{artists} - {title}.{output-ext}",
            "overwrite": "skip",
            "search_query": null,
            "ffmpeg": "ffmpeg",
            "bitrate": null,
            "ffmpeg_args": null,
            "save_file": null,
            "format": "opus",
            "filter_results": true,
            "threads": 8,
            "cookie_file": null,
            "restrict": false,
            "print_errors": false,
            "sponsor_block": false,
            "preload": false,
            "archive": null,
            "load_config": true,
            "log_level": "INFO",
            "simple_tui": false,
            "fetch_albums": false,
            "id3_separator": "/",
            "ytm_data": false,
            "add_unavailable": false,
            "generate_lrc": false,
            "force_update_metadata": false,
            "only_verified_results": false,
            "sync_without_deleting": false,
            "max_filename_length": null,
            "web_use_output_dir": false,
            "port": 8800,
            "host": "localhost",
            "keep_alive": false,
            "allowed_origins": null,
            "keep_sessions": false
          }
        '';
      };
    };
  };
}
