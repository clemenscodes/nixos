{ ... }: {
  imports = [
    ./services
    ./environment.nix
    ./nix.nix
    ./hyprland.nix
    ./boot.nix
    ./time.nix
    ./i18n.nix
    ./console.nix
    ./fonts.nix
    ./xdg.nix
    ./hardware.nix
    ./security.nix
    ./qt.nix
    ./system.nix
    ./users.nix
    ./networking.nix
    ./zsh.nix
  ];
}
