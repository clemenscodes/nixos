{...}: {
  imports = [
    ./boot.nix
    ./tpm.nix
    ./dconf.nix
    ./fonts.nix
    ./hardware.nix
    ./networking.nix
    ./virtualisation.nix
    ./gtk.nix
    ./xdg.nix
  ];
}
