{
  inputs,
  pkgs,
  lib,
  ...
}: {...}: {
  imports = [
    (import ./cardanix {inherit inputs pkgs;})
    ./ledger-live
    ./monero
    ./nanominer
    ./ravencoin
    ./teamredminer
  ];
  options = {
    modules = {
      crypto = {
        enable = lib.mkEnableOption "Enable cryptocurrency modules" // {default = false;};
      };
    };
  };
}
