{inputs, pkgs, ...}: {lib, ...}:
with lib; {
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
        enable = mkEnableOption "Enable cryptocurrency modules" // {default = false;};
      };
    };
  };
}
