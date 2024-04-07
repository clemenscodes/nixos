{
  user,
  locale,
  config,
  version,
  ...
}: {
  imports = [
    ./cli
  ];
  programs = {
    home-manager = {
      enable = true;
    };
  };
  home = {
    keyboard = {
      layout = locale;
    };
    stateVersion = version;
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
        source = ../../../assets/fonts;
        recursive = true;
      };
      ".local/share/nvim/undo/README.md" = {
        text = ''
          # Neovim undo direcotry

          - This is the directory where neovim stores its undo history
        '';
      };
    };
  };
}
