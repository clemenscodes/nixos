{
  inputs,
  pkgs,
  lib,
  ...
}: {...}: {
  imports = [
    (import ./postgres {inherit inputs pkgs lib;})
  ];
  options = {
    modules = {
      databases = {
        enable = lib.mkEnableOption "Enable databases" // {default = false;};
      };
    };
  };
}
