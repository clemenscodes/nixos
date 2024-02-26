{...}: {
  imports = [
    ./services
    ./scripts
    ./documentation.nix
    ./environment.nix
    ./nix.nix
    ./ld.nix
    ./boot.nix
    ./time.nix
    ./i18n.nix
    ./console.nix
    ./fonts.nix
    ./xdg.nix
    ./gtk.nix
    ./gnupg.nix
    ./hyprland.nix
    ./hardware.nix
    ./security.nix
    ./system.nix
    ./users.nix
    ./networking.nix
    ./virtualisation.nix
    ./zsh.nix
  ];
}
