{ pkgs, ... }: {
  xdg = {
    configFile = {
      rofi = {
        source = ./config;
        recursive = true;
      };
      "rofi/themes" = {
        source = ./config/themes;
        recursive = true;
      };
    };
  };
  programs = {
    rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      terminal = "${pkgs.kitty}/bin/kitty";
      font = "Iosevka Nerd Font 14";
      plugins = [];
      extraConfig = {};
    };
  };
}
