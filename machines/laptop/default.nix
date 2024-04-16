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
    home-manager = {
      users = {
        ${user} = {
          imports = [../../modules/home/desktop];
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
    secureboot = {
      enable = false;
    };
  };
}
