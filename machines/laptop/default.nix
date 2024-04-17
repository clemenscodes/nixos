{
  user,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/desktop
    ../../modules/desktop/tpm.nix
    ../../modules/services/desktop
    ../../modules/services/desktop/tlp.nix
    ../../modules/services/desktop/thermald.nix
    ../../modules/services/desktop/power.nix
    inputs.xremap-flake.nixosModules.default
    # evdi currently broken on kernel >= v6.5
    # @see https://github.com/NixOS/nixpkgs/issues/265868
    # ../../modules/services/displaylink.nix
  ];
  config = {
    modules = {
      enable = true;
    };
    secrets = {
      enable = true;
    };
    gpu = {
      enable = false;
      amd = {
        enable = false;
      };
    };
    secureboot = {
      enable = false;
    };
    home-manager = {
      users = {
        ${user} = {
          imports = [../../home/desktop];
          modules = {
            home = {
              enable = true;
            };
          };
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
  };
}
