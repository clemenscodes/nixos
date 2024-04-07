{...}: {
  imports = [
    ./services
    ./scripts
    ./environment.nix
    ./nix.nix
    ./ld.nix
    ./time.nix
    ./i18n.nix
    ./console.nix
    ./gnupg.nix
    ./security.nix
    ./system.nix
    ./users.nix
    ./zsh.nix
  ];
}
