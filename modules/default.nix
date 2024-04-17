{lib, ...}:
with lib; {
  imports = [
    ./gpu
    ./wsl

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
    ./sops.nix
    ./zsh.nix
  ];
  options = {
    modules = {
      enable = mkEnableOption "Enable custom modules" // {default = true;};
    };
  };
}
