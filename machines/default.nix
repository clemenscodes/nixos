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
      allowUnfree = true; # IntelliJ products are ignored in predicate
      allowUnfreePredicate = pkg:
        builtins.elem (lib.getName pkg) [
          "spotify"
          "discord"
          "steam"
          "steam-original"
          "steam-run"
        ];
      permittedInsecurePackages = [
        "electron-19.1.9"
      ];
    };
    overlays = [
      nur.overlay
      inputs.neovim-nightly-overlay.overlay
    ];
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
      ;
  };
  homeArgs = {
    inherit
      inputs
      themes
      user
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
  mkExtraSpecialArgs = machine:
    homeArgs
    // {
      machine = machine;
    };
  mkModules = {
    modulePath,
    machine,
  }: [
    modulePath
    inputs.home-manager.nixosModules.home-manager
    inputs.sops-nix.nixosModules.sops
    nix-ld.nixosModules.nix-ld
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = mkExtraSpecialArgs machine;
        users = {
          ${user} = {
            imports = [../modules/common/home];
          };
        };
      };
    }
    {
      sops = {
        defaultSopsFile = ../secrets/secrets.yaml;
        age = {
          keyFile = "/home/${user}/.config/sops/age/keys.txt";
          generateKey = false;
          sshKeyPaths = ["/home/${user}/.ssh/id_ed25519"];
        };
        secrets = {
          password = {
            neededForUsers = true;
          };
          wifi = {
            neededForUsers = true;
          };
          nix_access_tokens = {};
        };
      };
    }
    ../modules
  ];
  mkMachine = {
    modulePath,
    machine,
  }:
    lib.nixosSystem {
      specialArgs = machineArgs;
      modules = mkModules {
        modulePath = modulePath;
        machine = machine;
      };
    };
in {
  desktop = mkMachine {
    modulePath = ./desktop;
    machine = "desktop";
  };
  laptop = mkMachine {
    modulePath = ./laptop;
    machine = "laptop";
  };
  wsl = mkMachine {
    modulePath = ./wsl;
    machine = "wsl";
  };
}
