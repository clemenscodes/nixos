{ inputs, pkgs, ... }: { 
  imports = [ 
    ./hardware-configuration.nix 
    ../../modules/common/hyprland.nix
  ];

  networking = {
    wireless = {
      interfaces = [ "wlp0s20f3" ];   
    };
  };  

  programs = {
    zsh = {
      enable = true;
      shellAliases = {
        update = "cd $HOME/.config/nixos && git pull";
        switch = "update && sudo nixos-rebuild switch --flake ./#laptop";
      };
    };
  };
}
