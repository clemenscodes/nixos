{ user, ... }: {
  imports = [
    ./desktop
    ./development
  ];

  home = {
    stateVersion = "23.11";
    username = "${user}";
    homeDirectory = "/home/${user}";
    sessionPath = [ "/home/${user}/.local/bin" ];
    file = {
      ".local/bin/setupsops" = {
        text = ''
          #!/usr/bin/env bash
          
          mkdir -p ~/.config/sops/age
          nix run nixpkgs#ssh-to-age -- -private-key -i ~/.ssh/id_ed25519 > ~/.config/sops/age/keys.txt
          nix shell nixpkgs#age -c age-keygen -y ~/.config/sops/age/keys.txt
          cd ~/.config/nixos/secrets || exit
          nix shell nixpkgs#sops -c sops secrets.yaml
        '';
      };
      ".local/src/README.md" = {
        text = ''
          # Source Code / Packages
          
          - This is the home for all external source code and projects
        '';
      };
    };
  };

  programs = {
    home-manager = {
      enable = true;
    };
  };
}
