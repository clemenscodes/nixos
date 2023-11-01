{ ... }: {
  imports = [
    ./services
    ./environment.nix
    ./settings.nix
    ./boot.nix
    ./time.nix
    ./i18n.nix
    ./console.nix
    ./fonts.nix
  ];
}
