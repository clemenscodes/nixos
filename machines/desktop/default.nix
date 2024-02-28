{...}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/common/home/gaming
    ../../modules/amd.nix
    ../../modules/common/services/monero
    ../../modules/common/services/lact.nix
  ];
}
