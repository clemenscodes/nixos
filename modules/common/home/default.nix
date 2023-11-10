{ inputs, config, pkgs, lib, user, themes, ... }: {
  gtk = {
    enable = true;
  };
  xdg = {
    enable = true;
    mimeApps = {
      defaultApplications = {
        "application/pdf" = [ "zathura.desktop" ];
      };
    };
    dataFile = {
      wallpaper = {
        source = ../../../assets/wallpaper;
        recursive = true;
      };
    };
    configFile = {
      ctpv = {
        source = ./ctpv;
        recursive = true;
      };
      hypr = {
        source = ./hypr;
        recursive = true;
      };
      lf = {
        source = ./lf;
        recursive = true;
      };
      nvim = {
        source = ./nvim;
        recursive = true;
      };
      waybar = {
        source = ./waybar;
        recursive = true;
      };
      "waybar/scripts" = {
        source = ./waybar/scripts;
        recursive = true;
      };
      swaync = {
        source = ./swaync;
        recursive = true;
      };
      rofi = {
        source = ./rofi;
        recursive = true;
      };
    };
  };
  services = {
    mpd = {
      enable = true;
      musicDirectory = "/home/${user}/.config/mpd/music";
      playlistDirectory = "/home/${user}/.config/mpd/playlists";
      dataDir = "/home/${user}/.config/mpd";
      dbFile = "/home/${user}/.config/mpd/tag_cache";
      extraConfig = ''
        user "${user}"

        audio_output {
          type "pulse"
          name "Pulse"
        }

        audio_output {
          type   "fifo"
          name   "fifo"
          path   "${config.services.mpd.dataDir}/fifo"
          format "44100:16:2"
        }

        bind_to_address "/run/user/1000/mpd/socket"
        auto_update "yes"
        zeroconf_enabled "no"
      '';
      network = {
        startWhenNeeded = true;
      };
    };
  };
  home = {
    stateVersion = "23.11";
    username = "${user}";
    homeDirectory = "/home/${user}";
    packages = with pkgs; [
      file
      brave
      eza
      ctpv
      ripgrep
      fd
      wl-clipboard
      gcc
      mpc-cli
      gnumake
      cmake
      cmake-format
      clang-tools
      nasm
      nodejs_20
      gdb
      pwndbg
      nodePackages.pnpm
      nodePackages.yarn
      btop
      bun
      jetbrains.idea-ultimate
      tree-sitter
      wget
      zip
      unzip
      go
      php82Packages.composer
      php
      cargo
      luajitPackages.luarocks
      zulu
      julia
      (python311.withPackages(ps: with ps; [pip]))
      ffmpeg
      ffmpegthumbnailer
      poppler_utils
      jq
      gnupg
      imagemagick_light
      atool
      glow
      swww
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-wlr
      brightnessctl
      swaynotificationcenter
      libnotify
    ];
    sessionVariables = {
      EDITOR = "nvim";
    };
  };
  programs = {
    home-manager = {
      enable = true;
    };
    fzf = {
      enable = true;
    };
    direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
      };
    };
    waybar = {
      enable = true;
      package = (pkgs.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      }));
    };
    rofi = {
      enable = true;
      extraConfig = {};
    };
    mpv = with pkgs; {
      enable = true;
      package = (mpv.override { scripts = [ mpvScripts.mpris ]; });
    };
    ncmpcpp = {
      enable = true;
      package = pkgs.ncmpcpp.override { visualizerSupport = true; clockSupport = true; };
      mpdMusicDir = ''"/home/${user}/.config/mpd/music"'';
      settings = {
        lyrics_directory = ''/home/${user}/.local/share/lyrics'';
        mpd_host = "/run/user/1000/mpd/socket";
        mpd_port = 6600;
        mpd_connection_timeout = 5;
        mpd_crossfade_time = 5;
        visualizer_data_source = ''${config.services.mpd.dataDir}/fifo'';
        visualizer_output_name = "fifo";
        message_delay_time = "1";
        visualizer_type = "spectrum";
        song_list_format = ''{$4%a - }{%t}|{$8%f$9}$R{$3(%l)$9}'';
        song_status_format = ''$b{{$8"%t"}} $3by {$4%a{ $3in $7%b{ (%y)}} $3}|{$8%f}'';
        song_library_format = ''{%n - }{%t}|{%f}'';
        alternative_header_first_line_format = ''$b$1$aqqu$/a$9 {%t}|{%f} $1$atqq$/a$9$/b'';
        alternative_header_second_line_format = ''{{$4$b%a$/b$9}{ - $7%b$9}{ ($4%y$9)}}|{%D}'';
        current_item_prefix = ''$(cyan)$r$b'';
        current_item_suffix = ''$/r$(end)$/b'';
        current_item_inactive_column_prefix = ''$(magenta)$r'';
        current_item_inactive_column_suffix = ''$/r$(end)'';
        playlist_display_mode = ''columns'';
        browser_display_mode = ''columns'';
        progressbar_look = ''->'';
        media_library_primary_tag = ''album_artist'';
        media_library_albums_split_by_date = ''no'';
        startup_screen = ''media_library'';
        display_volume_level = ''no'';
        ignore_leading_the = ''yes'';
        external_editor = ''nvim'';
        use_console_editor = ''yes'';
        empty_tag_color = ''magenta'';
        main_window_color = ''white'';
        progressbar_color = ''black:b'';
        progressbar_elapsed_color = ''blue:b'';
        statusbar_color = ''red'';
        statusbar_time_color = ''cyan:b'';
      };
      bindings = [
        { key = "+"; command = "show_clock"; }
        { key = "="; command = "volume_up"; }
        { key = "j"; command = "scroll_down"; }
        { key = "k"; command = "scroll_up"; }
        { key = "u"; command = "page_up"; }
        { key = "d"; command = "page_down"; }
        { key = "h"; command = "previous_column"; }
        { key = "l"; command = "next_column"; }
        { key = "."; command = "show_lyrics"; }
        { key = "n"; command = "next_found_item"; }
        { key = "N"; command = "previous_found_item"; }
        { key = "J"; command = "move_sort_order_down"; }
        { key = "K"; command = "move_sort_order_up"; }
        { key = "h"; command = "jump_to_parent_directory"; }
        { key = "l"; command = "enter_directory"; }
        { key = "l"; command = "run_action"; }
        { key = "l"; command = "play_item"; }
        { key = "m"; command = "show_media_library"; }
        { key = "m"; command = "toggle_media_library_columns_mode"; }
        { key = "t"; command = "show_tag_editor"; }
        { key = "v"; command = "show_visualizer"; }
        { key = "G"; command = "move_end"; }
        { key = "g"; command = "move_home"; }
        { key = "U"; command = "update_database"; }
        { key = "s"; command = "reset_search_engine"; }
        { key = "s"; command = "show_search_engine"; }
        { key = "f"; command = "show_browser"; }
        { key = "f"; command = "change_browse_mode"; }
        { key = "x"; command = "delete_playlist_items"; }
        { key = "P"; command = "show_playlist"; }
        { key = "ctrl-u"; command = "page_up"; }
        { key = "ctrl-d"; command = "page_down"; }
      ];
    };
    gh = {
      enable = true;
      settings = {
        editor = "nvim";
        git_protocol = "ssh";
        browser = "brave";
      };
      gitCredentialHelper = {
        enable = true;
      };
    };
    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        add_newline = false;
        command_timeout = 500;
        hostname = {
          style = "bold #ff5555";
        };
        username = {
          format = "[$user]($style) on ";
          show_always = true;
          style_user = "bold #bd93f9";
          style_root = "bright-red bold";
        };
        directory = {
          style = "bold #50fa7b";
          truncation_length = 6;
          truncate_to_repo = true;
          truncation_symbol = ".../";
        };
        line_break = {
          disabled = true;
        };
        cmd_duration = {
          style = "bold #f1fa8c";
        };
        git_branch = {
          format = "[$symbol](green)[$branch]($style)";
          style = "bold #ff79c6";
        };
        git_status = {
          format = "[$all_status$ahead_behind]($style) ";
          style = "bold #ff5555";
          conflicted = " ⚔️  ";
          ahead = " 🏎️ 💨 <== \${count}";
          behind = " 🐢 => \${count}";
          diverged = " 🔱 <== \${ahead_count} 🐢 => \${behind_count}";
          untracked = " 🛤️ -> \${count}";
          stashed = " 📦 ";
          modified = " 📝 => \${count}";
          staged = " 🗃️ -> \${count}";
          renamed = " 📛 <!= \${count}";
          deleted = " 🗑️ <!= \${count}";
        };
      	battery = {
      	  full_symbol = "🔋";
          charging_symbol = "🔌";
          discharging_symbol = "⚡";
        };
      };
    };
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };
    git = {
      enable = true;
      userName = "Clemens Horn";
      userEmail = "clemens.horn@mni.thm.de";
      extraConfig = {
        init = {
          defaultBranch = "main";
        };
        pull = {
          rebase = false;
        };
        push = {
          autoSetupRemote = true;
        };
        core = {
          whitespace = "trailing-space,space-before-tab";
          editor = "nvim";
        };
      };
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting = {
        enable = true;
      };
      enableAutosuggestions = true;
      autocd = true;
      completionInit = true;
      oh-my-zsh = {
        enable = true;
        plugins = [ 
          "git"
          "colored-man-pages"
          "colorize"
        ];
      };
      dotDir = ".config/zsh";
      shellAliases = {
        ls = "${pkgs.eza}/bin/eza";
        ne = "cd $NIX_CONFIG_HOME && lfcd";
        src = "omz reload";
        rr = "cd $HOME/.local/src";
      };
      history = {
        path =  "${config.xdg.dataHome}/zsh/zsh_history";
      };
      historySubstringSearch = {
        enable = true;
      };
      initExtraBeforeCompInit = ''
        autoload -U colors && colors
      '';
      initExtra = ''
        zstyle ':completion*' menu select
        bindkey -v
        bindkey -M menuselect 'h' vi-backward-char
        bindkey -M menuselect 'k' vi-up-line-or-history
        bindkey -M menuselect 'l' vi-forward-char
        bindkey -M menuselect 'j' vi-down-line-or-history
        bindkey -v '^?' backward-delete-char
        function zle-keymap-select () {
            case $KEYMAP in
                vicmd) echo -ne '\e[1 q';;
                viins|main) echo -ne '\e[5 q';;
            esac
        }
        zle -N zle-keymap-select
        zle-line-init() {
            zle -K viins
            echo -ne "\e[5 q"
        }
        zle -N zle-line-init
        echo -ne '\e[5 q' 
        preexec() { echo -ne '\e[5 q' ;} 
        lfcd () {
            tmp="$(mktemp -uq)"
            trap 'rm -f $tmp >/dev/null 2>&1' HUP INT QUIT TERM PWR EXIT
            lf -last-dir-path="$tmp" "$@"
            if [ -f "$tmp" ]; then
                dir="$(cat "$tmp")"
                [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
            fi
        }
        bindkey -s '^o' 'lfcd\n'
        autoload edit-command-line; zle -N edit-command-line
        bindkey '^e' edit-command-line
        bindkey -M vicmd '^[[P' vi-delete-char
        bindkey -M vicmd '^e' edit-command-line
        bindkey -M visual '^[[P' vi-delete
      '';
      profileExtra = ''
        export NIX_CONFIG_HOME=$XDG_CONFIG_HOME/nixos
        Hyprland &
      '';
    };
    kitty = {
      enable = true;
      settings = with themes.custom; {
        dynamic_background_opacity = "yes";
        font_family = "Iosevka Nerd Font";
        shell_integration = "enabled";
        enable_audio_bell = false;
        shell = "zsh";
        confirm_os_window_close = 0;
        font_size = "14.0";
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
    zathura = {
      enable = true;
    };
    lf = {
      enable = true;
      settings = {
        hidden = true;
        icons = true;
        preview = true;
        ignorecase = true;
        drawbox = true;
        ifs = ''\n'';
        scrolloff = 10;
        period = 1;
      };
      commands = {
        open = ''''${{
          case $(file --mime-type "$(readlink -f $f)" -b) in
              application/pdf | application/vnd* | application/epub*) setsid -f zathura $fx >/dev/null 2>&1 ;;
              audio/*) mpv --audio-display=no $f ;;
              video/*) setsid -f mpv $f -quiet >/dev/null 2>&1 ;;
              text/* | application/* | inode/x-empty) $EDITOR $fx ;;
              *) for f in $fx; do setsid -f $OPENER $f >/dev/null 2>&1; done;;
          esac
          }}
        '';
        delete = ''''${{
          clear; tput cup $(($(tput lines)/3)); tput bold
          set -f
          printf "%s\n\t" "$fx"
          printf "delete ? [y/N]"
          read ans
          [ $ans = "y" ] && rm -rf -- $fx
          }}
        '';
        mkdir = ''''${{
          printf "Directory Name: "
          read DIR
          mkdir $DIR
          }}
        '';
      };
      keybindings = {
        V = "push :!nvim<space>";
        W = ''$setsid -f $TERMINAL >/dev/null 2>&1'';
        D = "delete";
        "<c-n>" = "mkdir";
        "<c-r>" = "reload";
        "<enter>" = "shell";
      };
      previewer = {
        source = "${pkgs.ctpv}/bin/ctpv";
      };
      extraConfig = ''
        &${pkgs.ctpv}/bin/ctpv -s $id
        cmd on-quit %${pkgs.ctpv}/bin/ctpv -e $id
        set cleaner ${pkgs.ctpv}/bin/ctpvclear
        set shellopts '-eu'
      '';
    };
    vscode = {
      enable = true;
      package = pkgs.vscode.fhs;
    };
  };
}
