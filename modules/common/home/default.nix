{
  user,
  locale,
  config,
  ...
}: {
  imports = [
    ./desktop
    ./development
    ./editing
  ];

  home = {
    keyboard = {
      layout = locale;
    };
    stateVersion = "23.11";
    username = "${user}";
    homeDirectory = "/home/${user}";
    sessionPath = ["${config.home.homeDirectory}/.local/bin"];
    file = {
      ".local/share/images/screenshots/README.md" = {
        text = ''
          # Screenshots

          - This is the directory where screenshots will be saved by swappy
          - run `sss to cd into this directory
        '';
      };
      ".local/src/README.md" = {
        text = ''
          # Source Code / Packages

          - This is the home for all external source code and projects
          - run `rr` to cd into this directory
        '';
      };
      ".local/share/fonts" = {
        source = config.lib.file.mkOutOfStoreSymlink "/run/current-system/sw/share/X11/fonts";
      };
      ".fonts" = {
        source = config.lib.file.mkOutOfStoreSymlink "/run/current-system/sw/share/X11/fonts";
      };
    };
  };

  programs = {
    home-manager = {
      enable = true;
    };
  };
}
