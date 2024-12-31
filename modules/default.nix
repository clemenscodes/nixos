{
  inputs,
  pkgs,
  lib,
  ...
}: {...}: {
  imports = [
    (import ./boot {inherit inputs;})
    ./config
    ./cpu
    (import ./crypto {inherit inputs pkgs;})
    ./databases
    (import ./disk {inherit inputs pkgs lib;})
    ./display
    ./docs
    ./fonts
    (import ./gaming {inherit inputs;})
    ./gpu
    ./hostname
    (import ./home-manager {inherit inputs pkgs;})
    (import ./io {inherit inputs;})
    ./locale
    ./machine
    ./networking
    ./performance
    (import ./security {inherit inputs;})
    ./shell
    ./system
    (import ./themes {inherit inputs;})
    ./time
    ./users
    (import ./virtualisation {inherit inputs;})
    (import ./wsl {inherit inputs;})
    ./xdg
  ];
  options = {
    modules = {
      enable = lib.mkEnableOption "Enable custom modules" // {default = true;};
    };
  };
}
