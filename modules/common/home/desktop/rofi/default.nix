{ pkgs, ... }: {
  xdg = {
    configFile = {
      rofi = {
        source = ./config;
        recursive = true;
      };
    };
  };
  programs = {
    rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      terminal = "${pkgs.kitty}/bin/kitty";
      plugins = [];
      font = "Iosevka Nerd Font 14";
      extraConfig = {};
    };
  };
}
