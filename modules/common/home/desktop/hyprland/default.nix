{ pkgs, ... }: {
  home = {
    packages = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-wlr
      brightnessctl
      swww
    ];
  };
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
    dataFile = {
      wallpaper = {
        source = ../../../../../assets/wallpaper;
        recursive = true;
      };
    };
    configFile = {
      hypr = {
        source = ./config;
        recursive = true;
      };
    };
  };
}
