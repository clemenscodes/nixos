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
      git
      gh
      zsh
      oh-my-zsh
      brave
      kitty
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
      xdg-desktop-portal-hyprland
      glow
    ];
    file = {
      ".background-image" = {
        source = ../../assets/wallpaper/luffycolor.png;
      };
      ".hyprrc" = {
        source = ./hypr/.hyprrc;
      };
    };
    sessionVariables = {
      EDITOR = "nvim";
    };
  };
  programs = {
    home-manager = {
      enable = true;
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
      oh-my-zsh = {
        theme = "lambda";
        enable = true;
        plugins = [ 
          "git"
          "colored-man-pages"
        ];
      };
      profileExtra = ''
        $HOME/.hyprrc
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
