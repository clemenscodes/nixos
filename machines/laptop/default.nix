{user, inputs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/common/gaming
    ../../modules/common/desktop
    ../../modules/common/services/desktop
    ../../modules/common/services/desktop/tlp.nix
    ../../modules/common/services/desktop/thermald.nix
    ../../modules/common/services/desktop/power.nix
    inputs.xremap-flake.nixosModules.default
    # evdi currently broken on kernel >= v6.5
    # @see https://github.com/NixOS/nixpkgs/issues/265868
    # ../../modules/common/services/displaylink.nix
  ];
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      ${user} = {
        imports = [../../modules/common/home/desktop];
      };
    };
  };
}
