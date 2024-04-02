{
  description = "Clays NixOS flake";

  inputs = {
    nixpkgs-unstable = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-23.11";
    };
    wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs = {
        nixpkgs = {
          follows = "nixpkgs";
        };
      };
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
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs = {
        hyprland = {
          follows = "hyprland";
        };
      };
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
    nix-ld = {
      url = "github:Mic92/nix-ld";
      inputs = {
        nixpkgs = {
          follows = "nixpkgs";
        };
      };
    };
    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs = {
        nixpkgs = {
          follows = "nixpkgs";
        };
      };
    };
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
    };
    aiken = {
      url = "github:aiken-lang/aiken";
    };
    cardano-node = {
      url = "github:intersectmbo/cardano-node";
    };
    cardano-cli = {
      url = "github:intersectmbo/cardano-cli";
    };
    cardano-wallet = {
      url = "github:cardano-foundation/cardano-wallet";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    nixpkgs-unstable,
    wsl,
    home-manager,
    hyprland,
    nur,
    alejandra,
    nix-ld,
    aiken,
    cardano-node,
    cardano-cli,
    cardano-wallet,
    ...
  }: let
    user = "clay";
    locale = "de";
    terminal = "kitty";
    browser = "firefox";
    editor = "nvim";
    timezone = "Europe/Berlin";
    hostname = "nixos";
    system = "x86_64-linux";
  in {
    nixosConfigurations = (
      import ./machines {
        inherit (nixpkgs) lib;
        inherit
          inputs
          nixpkgs
          nixpkgs-unstable
          wsl
          home-manager
          hyprland
          nur
          alejandra
          nix-ld
          user
          locale
          terminal
          browser
          editor
          timezone
          hostname
          system
          ;
      }
    );
    formatter = {
      "${system}" = nixpkgs.legacyPackages.${system}.alejandra;
    };
  };
}
