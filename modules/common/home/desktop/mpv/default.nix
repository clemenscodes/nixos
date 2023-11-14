{ pkgs, ... }: {
  programs = {
    mpv = with pkgs; {
      enable = true;
      package = (mpv.override { scripts = [ mpvScripts.mpris ]; });
      bindings = {
        l = "seek 5";
        h = "seek -5";
        j = "seek -60";
        k = "seek 60";
        S = "cycle sub";
      };
    };
  };
}
