{...}: {
  programs = {
    zathura = {
      enable = true;
      options = {
        sandbox = "none";
        statusbar-h-padding = 0;
        statusbar-v-padding = 0;
        page-padding = 1;
        selection-clipboard = "clipboard";
      };
      mappings = {
        u = "scroll half-up";
        d = "scroll half-down";
        D = "toggle_page_mode";
        r = "reload";
        R = "rotate";
        K = "zoom in";
        J = "zoom out";
        i = "recolor";
        p = "print";
        g = "goto top";
      };
    };
  };
  xdg = {
    enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = ["zathura.desktop"];
      };
    };
    desktopEntries = {
      zathura = {
        name = "Zathura";
        type = "Application";
        genericName = "PDF Viewer";
        exec = "zathura %U";
        icon = "org.pwmt.zathura";
        terminal = false;
        categories = ["Viewer"];
        mimeType = ["application/pdf"];
      };
    };
  };
}
