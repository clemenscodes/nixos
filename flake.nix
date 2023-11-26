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
    nur = {
      url = "github:nix-community/NUR";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs = {
        nixpkgs = {
          follows = "nixpkgs";
        };
      };
    };
    alejandra = {
      url = "github:kamadorueda/alejandra/3.0.0";
      inputs = {
        nixpkgs = {
          follows = "nixpkgs";
        };
      };
    };
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    hyprland,
    nur,
    alejandra,
    ...
  }: let
    user = "clay";
    locale = "de";
    terminal = "kitty";
    browser = "firefox";
    editor = "nvim";
    timezone = "Europe/Berlin";
    hostname = "nixos";
  in {
    nixosConfigurations = (
      import ./machines {
        inherit (nixpkgs) lib;
        inherit
          inputs
          nixpkgs
          home-manager
          hyprland
          nur
          alejandra
          user
          locale
          terminal
          browser
          editor
          timezone
          hostname
          ;
      }
    );
    formatter = {
      x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
    };
  };
}
