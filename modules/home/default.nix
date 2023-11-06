{ inputs, config, pkgs, lib, ... }: {
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
        source = ../../assets/wallpaper;
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
    };
  };
  home = {
    stateVersion = "22.11";
    username = "clay";
    homeDirectory = "/home/clay";
    packages = with pkgs; [
      kitty
      git
      gh
      zsh
      oh-my-zsh
      brave
      eza
      lf
      zathura
      ctpv
      ffmpeg
      ffmpegthumbnailer
      poppler_utils
      jq
      gnupg
      imagemagick_light
      atool
      glow
      (waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      }))
      swww
      xdg-desktop-portal-hyprland
    ];
    sessionVariables = {
      EDITOR = "nvim";
    };
  };
  programs = {
    home-manager = {
      enable = true;
    };
    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        add_newline = false;
	os = {
          format = "[$symbol](bold white)";
	  disabled = false;
	};
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
	  truncation_length = 3;
	  truncate_to_repo = true;
	  truncation_symbol = ".../";
	};
        character = {
          success_symbol = "[✅](bold #f8f8f2)";
	  error_symbol = "[❌](bold #ff5555)";
	  vicmd_symbol = "[[](bg:#545B68 fg:#A6A6A6)[](bg:#A6A6A6 fg:#545B68)](bold bg:#545B68 fg:#FF6E79)";
          format = "$symbol -> ";
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
	  format = "[$all_status -> $ahead_behind]($style)";
          style = "bold #ff5555";
	  conflicted = "⚔️ ";
          ahead = "🏎️💨===!>\${count}";
          behind = "🐢=>\${count}";
          diverged = "🔱🏎️💨<=\${ahead_count}🐢=>\${behind_count}";
          untracked = "🛤️=>\${count}";
          stashed = "📦";
          modified = "📝=>\${count}";
          staged = "🗃️->\${count}";
          renamed = "📛<!=\${count}";
          deleted = "🗑️<!=\${count}";
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
        theme = "lambda";
        enable = true;
        plugins = [ 
          "git"
          "colored-man-pages"
        ];
      };
      dotDir = ".config/zsh";
      shellAliases = with pkgs; {
        ls = "${eza}/bin/eza";
        l = "${eza}/bin/eza -lah";
        ll = "${eza}/bin/eza -l";
        la = "${eza}/bin/eza -a";
        lt = "${eza}/bin/eza --tree";
        lla = "${eza}/bin/eza -la";
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
                vicmd) echo -ne '\e[1 q';;      # block
                viins|main) echo -ne '\e[5 q';; # beam
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
        Hyprland &
      '';
    };
    kitty = {
      enable = true;
      settings = {
        dynamic_background_opacity = "yes";
        font_family = "Iosevka";
        shell_integration = "enabled";
        enable_audio_bell = false;
        shell = "zsh";
        confirm_os_window_close = 0;
        font_size = "14.0";
        background = "#282828";
        foreground = "#d6dae4";
        cursor = "#b9b9b9";
        selection_background = "#1f1f1f";
        color0 = "#1f1f1f";
        color8 = "#d6dae4";
        color1 = "#f71118";
        color9 = "#de342e";
        color2 = "#2cc55d";
        color10 = "#1dd260";
        color3 = "#ecb90f";
        color11 = "#f2bd09";
        color4 = "#61afef";
        color12 = "#61afef";
        color5 = "#4e59b7";
        color13 = "#524fb9";
        color6 = "#0f80d5";
        color14 = "#0f7cda";
        color7 = "#d6dae4";
        color15 = "#ffffff";
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
