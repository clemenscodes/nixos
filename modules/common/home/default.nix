{ user, ... }: {
  imports = [
    ./desktop
    ./development
  ];
  home = {
    stateVersion = "23.11";
    username = "${user}";
    homeDirectory = "/home/${user}";
  };
  programs = {
    home-manager = {
      enable = true;
    };
  };
}
