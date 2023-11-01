{ ... }: {
  imports = [
    ./services
    ./environment.nix
    ./settings.nix
    ./boot.nix
    ./networking.nix
    ./time.nix
    ./i18n.nix
    ./console.nix
    ./fonts.nix
  ];
}
