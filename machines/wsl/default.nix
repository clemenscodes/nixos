{inputs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/wsl.nix
    inputs.wsl.nixosModules.default
  ];
}
