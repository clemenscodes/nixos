{ ... }: {
  imports = [
    ./services
    ./scripts
    ./environment.nix
    ./nix.nix
    ./boot.nix
    ./time.nix
    ./i18n.nix
    ./console.nix
    ./fonts.nix
    ./xdg.nix
    ./gtk.nix
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
