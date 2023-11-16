{ pkgs, ... }: {
  programs = {
    swaylock = {
      enable = true;
      package = pkgs.swaylock-effects;
      settings = {
        color = "808080";
        font-size = 24;
        line-color = "ffffff";
        show-failed-attempts = true;
        clock = true;
        image = "$XDG_DATA_HOME/wallpaper/ring.jpeg";
      };
    };
  };
}
