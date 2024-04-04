{...}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/common/gaming
    ../../modules/amd.nix
    ../../modules/common/desktop
    ../../modules/common/services/desktop
    ../../modules/common/services/desktop/monero
    ../../modules/common/services/desktop/nanominer
    ../../modules/common/services/desktop/lact.nix
    ../../modules/common/services/desktop/corectrl.nix
    ../../modules/common/services/desktop/ravencoin
    ../../modules/common/services/desktop/teamredminer
  ];
}
