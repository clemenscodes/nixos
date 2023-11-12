{ config, inputs, user, ... }: {
  imports = [
    ./desktop
    ./development
  ];
  xdg = {
    configFile = {
      bin = {
        source = ../../../scripts;
        recursive = true;
      };
    };
  };
  home = {
    stateVersion = "23.11";
    username = "${user}";
    homeDirectory = "/home/${user}";
    sessionPath = [ "/home/${user}/.config/bin" ];
  };
  programs = {
    home-manager = {
      enable = true;
    };
  };
}
