{ ... }: { 
  imports = [ 
    ./hardware-configuration.nix 
  ];

  networking = {
    wireless = {
      interfaces = [ "wlp0s20f3" ];   
    };
  };  

  programs = {
    zsh = {
      shellAliases = {
        update = "cd $HOME/.config/nixos && git pull";
        switch = "update && sudo nixos-rebuild switch --flake ./#laptop";
      };
    };
  };
}
