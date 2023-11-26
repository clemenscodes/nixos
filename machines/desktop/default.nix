{...}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/nvidia.nix
    ../../modules/common/home/gaming
  ];
}
