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
      images = {
        source = ../../../../../assets/svg;
        recursive = true;
      };
    };
    configFile = {
      nixpkgs = {
        source = ../nixpkgs;
        recursive = true;
      };
    };
  };
}
