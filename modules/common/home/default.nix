{ config, inputs, user, lib, homeage, ... }: {
  imports = [
    ./desktop
    ./development
    inputs.sops-nix.homeManagerModule
    homeage.homeManagerModules.homeage
  ];

  homeage = {
    identityPaths = [ "~/.ssh/id_ed25519" ];
  };

  sops = {
    age = {
      keyFile = "/home/${user}/.config/sops/age/keys.txt";
      sshKeyPaths = [ "/home/${user}/.ssh/id_ed25519" ];
    };
    secrets = {
      "email/uni/password" = {
        sopsFile = ../../../secrets/secrets.yaml;
        path = "/home/${user}/.config/secrets/email/uni/password";
      };
      "email/private/password" = {
        sopsFile = ../../../secrets/secrets.yaml;
        path = "/home/${user}/.config/secrets/email/private/password";
      };
      "email/business/password" = {
        sopsFile = ../../../secrets/secrets.yaml;
        path = "/home/${user}/.config/secrets/email/business/password";
      };
    };
  };

  home = {
    stateVersion = "23.11";
    username = "${user}";
    homeDirectory = "/home/${user}";
    sessionPath = [ "/home/${user}/.local/bin" ];
    file = {
      ".local/bin" = {
        source = ../../../home/scripts;
        recursive = true;
      };
      ".local/src" = {
        source = ../../../home/src;
        recursive = true;
      };
    };
  };
  xdg = {
    configFile = {
      nixpkgs = {
        source = ./nixpkgs;
        recursive = true;
      };
    };
  };
  programs = {
    home-manager = {
      enable = true;
    };
  };
}
