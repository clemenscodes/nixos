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
    homeage = {
      url = "github:jordanisaacs/homeage";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
    };
  };

  outputs = inputs @ 
    { nixpkgs
    , home-manager
    , hyprland
    , nur
    , homeage
    , ... 
  }:
  let
    user = "clay";
  in 
  {
    nixosConfigurations = (
      import ./machines {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs home-manager hyprland user nur homeage;
      }
    );
  };
}
