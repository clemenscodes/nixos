{ ... }: {
  imports = [ 
    ./hardware-configuration.nix
    ../../modules/common/services/tlp.nix
    ../../modules/common/services/thermald.nix
    ../../modules/common/services/power.nix
  ]; 
}
