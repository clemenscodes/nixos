{
  inputs,
  nixpkgs,
  user,
  nur,
  nix-ld,
  locale,
  browser,
  terminal,
  editor,
  timezone,
  hostname,
  system,
  uid,
  version,
  ...
}: let
  inherit (nixpkgs) lib;
  pkgs = import nixpkgs {
    inherit system;
    config = {
      allowUnfree = false;
      allowUnfreePredicate = pkg:
        builtins.elem (lib.getName pkg) [
          "steam"
          "steam-original"
          "steam-run"
        ];
    };
    overlays = [nur.overlay inputs.neovim-nightly-overlay.overlay];
  };
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
  };
  systemArgs = {
    inherit
      pkgs
      system
      nix-ld
      ;
  };
  homeArgs = {
    inherit
      inputs
      nixpkgs
      themes
      locale
      editor
      browser
      terminal
      timezone
      hostname
      system
      uid
      version
      ;
  };
  machineArgs = homeArgs // systemArgs;
  mkExtraSpecialArgs = {
    machine,
    user,
  }:
    homeArgs
    // {
      inherit machine user;
    };
  mkModules = {
    modulePath,
    machine,
    user,
  }: [
    modulePath
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = mkExtraSpecialArgs {inherit machine user;};
        users = {
          ${user} = {
            imports = [../modules/common/home];
          };
        };
      };
    }
    ../modules
  ];
  mkMachine = {
    modulePath,
    machine,
    user,
  }:
    lib.nixosSystem {
      specialArgs = machineArgs // {inherit user;};
      modules = mkModules {
        inherit user modulePath machine;
      };
    };
in {
  desktop = mkMachine {
    modulePath = ./desktop;
    machine = "desktop";
    inherit user;
  };
  laptop = mkMachine {
    modulePath = ./laptop;
    machine = "laptop";
    inherit user;
  };
  server = mkMachine {
    modulePath = ./server;
    machine = "server";
    inherit user;
  };
  wsl = mkMachine {
    modulePath = ./wsl;
    machine = "wsl";
    user = "nixos"; # Changing this might lead to issues, @see https://github.com/nix-community/NixOS-WSL/issues/250
  };
}
