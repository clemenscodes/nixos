{ inputs, nixpkgs, home-manager, user, ... }: 
let
  system = "x86_64-linux";
  pkgs = import nixpkgs {
    inherit system;
    config = {
      allowUnfree = true;
    };
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
  sops = (
    {
      sops = {
        defaultSopsFile = ../secrets/secrets.yaml;
        defaultSopsFormat = "yaml";
        age = {
          keyFile = "/home/${user}/.config/sops/age/keys.txt";
          sshKeyPaths = [ "/home/${user}/.ssh/id_ed25519" ];
        };
        secrets = {
          password = {};
        };
      };
    }
  );
  home = (
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { inherit themes inputs user; };
        users = {
          ${user} = import ../modules/common/home;
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
  ];
  args = (
    { inherit pkgs inputs system user themes; }
  );
in {
  desktop = nixpkgs.lib.nixosSystem {
    specialArgs = args;
    modules = [ 
      ./desktop
    ] ++ shared;
  };
  laptop = nixpkgs.lib.nixosSystem {
    specialArgs = args;
    modules = [
      ./laptop
      sops
    ] ++ shared;
  };
}
