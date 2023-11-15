{ ... }: { 
  imports = [ 
    ./hardware-configuration.nix 
    ../../modules/nvidia.nix
  ];
}
