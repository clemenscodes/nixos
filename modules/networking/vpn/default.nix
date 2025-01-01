{
  inputs,
  pkgs,
  lib,
  ...
}: {...}: {
  imports = [
    (import ./thm {inherit inputs pkgs lib;})
  ];
  options = {
    modules = {
      networking = {
        vpn = {
          enable = lib.mkEnableOption "Enable vpn" // {default = false;};
        };
      };
    };
  };
}
