{ ... }: {
  imports = [ 
    ./hardware-configuration.nix
    ../../modules/common/services/logind.nix
    ../../modules/common/services/tlp.nix
    ../../modules/common/services/thermald.nix
  ]; 
}
