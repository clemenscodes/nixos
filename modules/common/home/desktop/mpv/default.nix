{ pkgs, ... }: {
  programs = {
    mpv = with pkgs; {
      enable = true;
      package = (mpv.override { scripts = [ mpvScripts.mpris ]; });
    };
  };
}
