{ inputs, config, pkgs, ... }: { 
  imports = [ 
    ./hardware-configuration.nix 
    ../../modules
    ../../modules/nvidia.nix
    ../../modules/networking.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  programs = {
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    };
    zsh = {
      enable = true;
      shellAliases = {
        switch = "sudo nixos-rebuild switch --flake $HOME/.config/nixos/#desktop";
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
