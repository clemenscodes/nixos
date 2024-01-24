{...}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/common/services/tlp.nix
    ../../modules/common/services/thermald.nix
    ../../modules/common/services/power.nix
    ../../modules/common/home/gaming
    # evdi currently broken on kernel >= v6.5
    # @see https://github.com/NixOS/nixpkgs/issues/265868
    # ../../modules/common/services/displaylink.nix
  ];
}
