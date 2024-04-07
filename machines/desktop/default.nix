{user, inputs, ...}: {
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
    inputs.xremap-flake.nixosModules.default
  ];
  home-manager = {
    users = {
      ${user} = {
        imports = [../../modules/common/home/desktop];
      };
    };
  };
}
