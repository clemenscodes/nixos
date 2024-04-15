{
  user,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/amd.nix
    ../../modules/common/desktop
    ../../modules/common/desktop/secureboot.nix
    ../../modules/common/desktop/tpm.nix
    ../../modules/common/desktop/steam.nix
    ../../modules/common/services/desktop
    ../../modules/common/services/desktop/lact.nix
    ../../modules/common/services/desktop/corectrl.nix
    inputs.xremap-flake.nixosModules.default
  ];
  config = {
    home-manager = {
      users = {
        ${user} = {
          imports = [../../modules/common/home/desktop];
          bat = {
            enable = true;
          };
        };
      };
    };
    secureboot = {
      enable = false;
    };
  };
}
