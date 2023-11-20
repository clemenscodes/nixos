{ user, ... }: {
  xdg = {
    enable = true;
    mimeApps = {
      enable = true;
      associations = {
        added = {
          "x-scheme-handler/http" = [ "firefox.desktop" ];
          "x-scheme-handler/https" = [ "firefox.desktop" ];
          "x-scheme-handler/chrome" = [ "firefox.desktop" ];
          "text/html" = [ "firefox.desktop" ];
          "application/x-extension-htm" = [ "firefox.desktop" ];
          "application/x-extension-html" = [ "firefox.desktop" ];
          "application/x-extension-shtml" = [ "firefox.desktop" ];
          "application/xhtml+xml" = [ "firefox.desktop" ];
          "application/x-extension-xhtml" = [ "firefox.desktop" ];
          "application/x-extension-xht" = [ "firefox.desktop" ];
        };
        removed = {};
      };
      defaultApplications = {
        "application/pdf" = [ "zathura.desktop" ];
        "x-scheme-handler/http" = [ "firefox.desktop" ];
        "x-scheme-handler/https" = [ "firefox.desktop" ];
        "x-scheme-handler/chrome" = [ "firefox.desktop" ];
        "text/html" = [ "firefox.desktop" ];
        "application/x-extension-htm" = [ "firefox.desktop" ];
        "application/x-extension-html" = [ "firefox.desktop" ];
        "application/x-extension-shtml" = [ "firefox.desktop" ];
        "application/xhtml+xml" = [ "firefox.desktop" ];
        "application/x-extension-xhtml" = [ "firefox.desktop" ];
        "application/x-extension-xht" = [ "firefox.desktop" ];
      };
    };
    desktopEntries = {
      firefox = {
        name = "Firefox";
        genericName = "Web Browser";
        exec = "firefox %U";
        icon = "firefox";
        terminal = false;
        categories = [ "Application" "Network" "WebBrowser" ];
        mimeType = [ "text/html" "text/xml" ];
      };
    };
    userDirs = 
      let 
        home = "/home/${user}";
        local = "${home}/.local";
        config = "${home}/.config";
      in
    {
      enable = true;
      createDirectories = true;
      music = "${config}/mpd/music";
      documents = "${local}/share/documents";
      pictures = "${local}/share/images";
      videos = "${local}/share/videos";
      desktop = "${local}/share/desktop";
      download = "${local}/share/downloads";
      publicShare = "${local}/share/public";
      templates = "${local}/share/templates";
      extraConfig = {
        XDG_BIN_HOME = "${local}/bin";
      };
    };
    dataFile = {
      "images/wallpaper" = {
        source = ../../../../../assets/wallpaper;
        recursive = true;
      };
      "images/svg" = {
        source = ../../../../../assets/svg;
        recursive = true;
      };
      "isos/README.md" = {
        text = ''
          # Iso images

          - store iso images here
          - run `isos` to cd into this directory
        '';
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
