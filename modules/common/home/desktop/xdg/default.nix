{ ... }: {
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
  };
}
