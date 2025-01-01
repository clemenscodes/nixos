{
  inputs,
  pkgs,
  lib,
  ...
}: {...}: {
  imports = [
    (import ./boot {inherit inputs pkgs lib;})
    (import ./config {inherit inputs pkgs lib;})
    (import ./cpu {inherit inputs pkgs lib;})
    (import ./crypto {inherit inputs pkgs lib;})
    (import ./databases {inherit inputs pkgs lib;})
    (import ./disk {inherit inputs pkgs lib;})
    (import ./display {inherit inputs pkgs lib;})
    (import ./docs {inherit inputs pkgs lib;})
    (import ./fonts {inherit inputs pkgs lib;})
    (import ./gaming {inherit inputs pkgs lib;})
    (import ./gpu {inherit inputs pkgs lib;})
    (import ./hostname {inherit inputs pkgs lib;})
    (import ./home-manager {inherit inputs pkgs;})
    (import ./io {inherit inputs pkgs lib;})
    (import ./locale {inherit inputs pkgs lib;})
    (import ./machine {inherit inputs pkgs lib;})
    (import ./networking {inherit inputs pkgs lib;})
    (import ./performance {inherit inputs pkgs lib;})
    (import ./security {inherit inputs pkgs lib;})
    (import ./shell {inherit inputs pkgs lib;})
    (import ./system {inherit inputs pkgs lib;})
    (import ./themes {inherit inputs pkgs lib;})
    (import ./time {inherit inputs pkgs lib;})
    (import ./users {inherit inputs pkgs lib;})
    (import ./virtualisation {inherit inputs pkgs lib;})
    (import ./wsl {inherit inputs pkgs lib;})
    (import ./xdg {inherit inputs pkgs lib;})
  ];
  options = {
    modules = {
      enable = lib.mkEnableOption "Enable custom modules" // {default = true;};
    };
  };
}
