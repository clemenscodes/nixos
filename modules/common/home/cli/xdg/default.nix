{config, ...}: {
  xdg = {
    enable = true;
    userDirs = let
      home = config.home.homeDirectory;
      local = "${home}/.local";
    in {
      enable = true;
      createDirectories = true;
      music = "${home}/music";
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
      "notes/README.md" = {
        text = ''
          # Notes

          - where general notes are stored
          - run `notes` to cd into this directory
        '';
      };
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
