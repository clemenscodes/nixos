{lib, ...}:
with lib; {
  imports = [
    ./cardanix
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
