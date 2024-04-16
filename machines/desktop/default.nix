{
  user,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/common/desktop
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
          jetbrains = {
            enable = true;
            clion = {
              enable = false;
            };
            pycharm = {
              enable = false;
            };
          };
        };
      };
    };
    gpu = {
      enable = true;
      amd = {
        enable = true;
      };
    };
    secureboot = {
      enable = true;
    };
  };
}
