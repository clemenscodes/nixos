{ user, ... }: {
  imports = [
    ./desktop
    ./development
  ];

  home = {
    stateVersion = "23.11";
    username = "${user}";
    homeDirectory = "/home/${user}";
    sessionPath = [ "/home/${user}/.local/bin" ];
    file = {
      "Downloads/README.md" = {
        text = ''
          # Downloads

          - This is the default folder for all downloads
          - run `D` to cd into this directory
        '';
      };
      ".local/src/README.md" = {
        text = ''
          # Source Code / Packages
          
          - This is the home for all external source code and projects
          - run `rr` to cd into this directory
        '';
      };
    };
  };

  programs = {
    home-manager = {
      enable = true;
    };
  };
}
