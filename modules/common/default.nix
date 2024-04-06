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
    ./fonts.nix
    ./xdg.nix
    ./gtk.nix
    ./gnupg.nix
    ./security.nix
    ./system.nix
    ./users.nix
    ./virtualisation.nix
    ./zsh.nix
  ];
}
