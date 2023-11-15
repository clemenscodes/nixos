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
