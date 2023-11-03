{ inputs, config, pkgs, ... }: { 
  imports = [ 
    ./hardware-configuration.nix 
    ../../modules
    inputs.home-manager.nixosModules.home-manager
    inputs.xremap-flake.nixosModules.default
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
    };
    zsh = {
      enable = true;
      shellAliases = {
        switch = "sudo nixos-rebuild switch --flake $HOME/.config/nixos/#laptop";
      };
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users = {
      clay = import ../../modules/home;
    };
  };

  users = {
    groups = {
      clay = {};
    };
    users = {
      clay = {
        isNormalUser = true; 
        description = "clay"; 
	group = "clay";
        extraGroups = [ "networkmanager" "wheel" ]; 
        shell = pkgs.zsh;
      };
    };
  };

  system = {
    stateVersion = "23.11";
  };
}
