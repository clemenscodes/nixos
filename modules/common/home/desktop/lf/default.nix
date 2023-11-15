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
    lf = with pkgs; {
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
              application/pdf | application/vnd* | application/epub*) ${util-linux}/bin/setsid -f ${zathura}/bin/zathura $fx >/dev/null 2>&1 ;;
              audio/*) ${mpv}/bin/mpv --audio-display=no $f ;;
              video/*) ${util-linux}/bin/setsid -f ${mpv}/bin/mpv $f -quiet >/dev/null 2>&1 ;;
              text/* | application/* | inode/x-empty) $EDITOR $fx ;;
              *) for f in $fx; do ${util-linux}/bin/setsid -f $OPENER $f >/dev/null 2>&1; done;;
          esac
          }}
        '';
        delete = ''''${{
          ${ncurses}/bin/clear; ${ncurses}/bin/tput cup $(($(tput lines)/3)); tput bold
          set -f
          ${toybox}/bin/printf "%s\n\t" "$fx"
          ${toybox}/bin/printf "delete ? [y/N]"
          read ans
          [ $ans = "y" ] && rm -rf -- $fx
          }}
        '';
        mkdir = ''''${{
          printf "Directory Name: "
          read DIR
          ${toybox}/bin/mkdir $DIR
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
        source = "${ctpv}/bin/ctpv";
      };
      extraConfig = ''
        &${ctpv}/bin/ctpv -s $id
        cmd on-quit %${ctpv}/bin/ctpv -e $id
        set cleaner ${ctpv}/bin/ctpvclear
        set shellopts '-eu'
      '';
    };
  };
}
