{ config, inputs, user, lib, ... }: {
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
      ".local/bin" = {
        source = ../../../home/scripts;
        recursive = true;
      };
      ".local/src" = {
        source = ../../../home/src;
        recursive = true;
      };
    };
  };
  programs = {
    home-manager = {
      enable = true;
    };
  };
}
