{ pkgs, ... }: {
  xdg = {
    configFile = {
      ctpv = {
        source = ./config/ctpv;
        recursive = true;
      };
      lf = {
        source = ./config;
        recursive = true;
      };
    };
  };
  home = {
    packages = with pkgs; [
      file
      ffmpeg
      ffmpegthumbnailer
      poppler_utils
      jq
      gnupg
      imagemagick_light
      atool
      glow
      ctpv
    ];
  };
  programs = {
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
              application/pdf | application/vnd* | application/epub*) setsid -f ${pkgs.zathura}/bin/zathura $fx >/dev/null 2>&1 ;;
              audio/*) ${pkgs.mpv}/bin/mpv --audio-display=no $f ;;
              video/*) setsid -f ${pkgs.mpv}/bin/mpv $f -quiet >/dev/null 2>&1 ;;
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
  };
}
