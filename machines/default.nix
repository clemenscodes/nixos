{ 
  inputs,
  nixpkgs,
  home-manager,
  user,
  nur,
  locale,
  browser,
  terminal,
  editor,
  ... 
}: 
let
  system = "x86_64-linux";
  pkgs = import nixpkgs {
    inherit system;
    config = {
      allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "nvidia-x11"
        "nvidia-settings"
        "code"
        "vscode"
        "idea-ultimate"
      ];
    };
    overlays = [ nur.overlay ];
  };
  lib = nixpkgs.lib;
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
  sops = (
    {
      sops = {
        defaultSopsFile = ../secrets/secrets.yaml;
        age = {
          keyFile = "/home/${user}/.config/sops/age/keys.txt";
          sshKeyPaths = [ "/home/${user}/.ssh/id_ed25519" ];
        };
        secrets = {
          password = {
            neededForUsers = true;
          };
          wifi = {
            neededForUsers = true;
          };
        };
      };
    }
  );
  home = (
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users = {
          ${user} = {
            imports = [ ../modules/common/home ];
          };
        };
      };
    }
  );
  shared = [
    ../modules
    inputs.home-manager.nixosModules.home-manager
    inputs.xremap-flake.nixosModules.default
    inputs.sops-nix.nixosModules.sops
    home
    sops
  ];
  systemArgs = { inherit 
    pkgs
    system
    ;
  };
  homeArgs = { inherit
    inputs
    themes
    user
    locale
    editor
    browser
    terminal
    ;
  };
  machineArgs = homeArgs // systemArgs;
  mkExtraSpecialArgs = machine: homeArgs // { 
    machine = machine;
  };
  mkMachine = { modulePath, machine }: 
    lib.nixosSystem {
      specialArgs = machineArgs;
      modules = [ 
        modulePath
      ] ++ shared ++ [
        {
          home-manager = {
            extraSpecialArgs = mkExtraSpecialArgs machine;
          };
        }
      ];
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
}

