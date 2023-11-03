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
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";
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
        specialArgs = { inherit inputs system; };
	modules = [ 
	  ./machines/desktop
	];
      };
      laptop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs system; };
        modules = [
          ./machines/laptop
        ];
      };
    };
  };
}
