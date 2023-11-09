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
      ncmpcpp = {
        source = ./ncmpcpp;
        recursive = true;
      };
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
  home = {
    stateVersion = "23.11";
    username = "${user}";
    homeDirectory = "/home/${user}";
    packages = with pkgs; [
      file
      brave
      eza
      ctpv
      fzf
      ripgrep
      fd
      wl-clipboard
      gcc
      mpd
      ncmpcpp
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
      };
      commands = {
        open = ''''${{
          case $(file --mime-type "$(readlink -f $f)" -b) in
              application/pdf | application/vnd* | application/epub*) setsid -f zathura $fx >/dev/null 2>&1 ;;
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
      '';
    };
  };
}
