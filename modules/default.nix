{inputs, pkgs, ...}: {lib, ...}:
with lib; {
  imports = [
    (import ./boot {inherit inputs;})
    ./config
    ./cpu
    (import ./crypto {inherit inputs pkgs;})
    ./databases
    ./display
    ./docs
    ./fonts
    (import ./gaming {inherit inputs;})
    ./gpu
    ./hostname
    (import ./home-manager {inherit inputs;})
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
      enable = mkEnableOption "Enable custom modules" // {default = true;};
    };
  };
}
