{
  user,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/desktop
    ../../modules/desktop/tpm.nix
    ../../modules/desktop/steam.nix
    ../../modules/services/desktop
    ../../modules/services/desktop/lact.nix
    ../../modules/services/desktop/corectrl.nix
    inputs.xremap-flake.nixosModules.default
  ];
  config = {
    home-manager = {
      users = {
        ${user} = {
          imports = [../../home/desktop];
          secrets = {
            enable = true;
          };
          email = {
            enable = true;
          };
          bat = {
            enable = true;
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
    secrets = {
      enable = true;
    };
  };
}
