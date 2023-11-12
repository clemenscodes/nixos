{ inputs, config, pkgs, user, themes, ... }: { 
  imports = [ 
    ./hardware-configuration.nix 
  ];

  networking = {
    hostName = "nixos";
    wireless = {
      enable = true;
      interfaces = [ "wlp0s20f3" ];   
    };
  };  

  programs = {
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      xwayland = {
        enable = true;
      };
    };
    zsh = {
      enable = true;
      shellAliases = {
        update = "cd $HOME/.config/nixos && git pull";
        switch = "update && sudo nixos-rebuild switch --flake ./#laptop";
      };
    };
  };
}
