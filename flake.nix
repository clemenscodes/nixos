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
    themes = {
      custom = {
        background = "282828";
        foreground = "d6dae4";
        cursor = "b9b9b9";
        base00 = "1f1f1f";
        base01 = "f71118";
        base02 = "2cc55d";
        base03 = "ecb90f";
        base04 = "61afef";
        base05 = "4e59b7";
        base06 = "0f80d5";
        base07 = "d6dae4";
        base08 = "d6dae4";
        base09 = "de342e";
        base0A = "1dd260";
        base0B = "f2bd09";
        base0C = "61afef";
        base0D = "524fb9";
        base0E = "0f7cda";
        base0F = "ffffff";
      };
      pop = {
        background = "282828";
        foreground = "d6dae4";
        cursor = "b9b9b9";
        base00 = "d0d0d0";
        base01 = "000000";
        base02 = "2cc55d";
        base03 = "f8ca12";
        base04 = "00aabb";
        base05 = "37b349";
        base06 = "b31e8d";
        base07 = "eb008a";
        base08 = "eb008a";
        base09 = "505050";
        base0A = "f8ca12";
        base0B = "37b349";
        base0C = "00aabb";
        base0D = "b31e8d";
        base0E = "0e5a94";
        base0F = "ffffff";
      };
    };
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
        specialArgs = { inherit pkgs inputs system user themes; };
          modules = [ 
            ./machines/desktop
          ];
      };
      laptop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit pkgs inputs system user themes; };
        modules = [
          ./machines/laptop
        ];
      };
    };
  };
}
