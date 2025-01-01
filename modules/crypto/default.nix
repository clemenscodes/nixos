{
  inputs,
  pkgs,
  lib,
  ...
}: {...}: {
  imports = [
    (import ./cardanix {inherit inputs pkgs lib;})
    (import ./ledger-live {inherit inputs pkgs lib;})
    (import ./monero {inherit inputs pkgs lib;})
    (import ./nanominer {inherit inputs pkgs lib;})
    (import ./ravencoin {inherit inputs pkgs lib;})
    (import ./teamredminer {inherit inputs pkgs lib;})
  ];
  options = {
    modules = {
      crypto = {
        enable = lib.mkEnableOption "Enable cryptocurrency modules" // {default = false;};
      };
    };
  };
}
