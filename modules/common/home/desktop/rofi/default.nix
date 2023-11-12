{ ... }: {
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
      extraConfig = {};
    };
  };
}
