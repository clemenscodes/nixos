{ inputs, pkgs, ... }: { 
  imports = [ 
    ./hardware-configuration.nix 
  ];

  networking = {
    wireless = {
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
