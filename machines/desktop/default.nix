{...}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/common/home/gaming
    ../../modules/amd.nix
    ../../modules/common/services/monero
    ../../modules/common/services/nanominer
    ../../modules/common/services/lact.nix
    ../../modules/common/services/corectrl.nix
    ../../modules/common/services/ravencoin
    ../../modules/common/services/teamredminer
  ];
}
