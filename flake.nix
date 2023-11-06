{
  description = "Clays NixOS flake";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs = {
        nixpkgs = {
	  follows = "nixpkgs";
	};
      };
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
    };
    xremap-flake = {
      url = "github:xremap/nix-flake";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs = {
        nixpkgs = {
	  follows = "nixpkgs";
	};
      };
    };
  };

  outputs = { self, nixpkgs, home-manager, sops-nix, ... }@inputs:
  let
    system = "x86_64-linux";
    user = "clay";
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };
  in 
  {
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs system user; };
	modules = [ 
	  ./machines/desktop
	];
      };
      laptop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs system user; };
        modules = [
          ./machines/laptop
        ];
      };
    };
  };
}
