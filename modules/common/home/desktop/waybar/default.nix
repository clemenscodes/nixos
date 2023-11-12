{ pkgs, ... }: {
  xdg = {
    configFile = {
      waybar = {
        source = ./config;
        recursive = true;
      };
      "waybar/scripts" = {
        source = ./config/scripts;
        recursive = true;
      };
    };
  };
  programs = {
    waybar = {
      enable = true;
      package = (pkgs.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      }));
    };
  };
}
