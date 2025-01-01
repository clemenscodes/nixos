{lib, ...}: {...}: {
  options = {
    modules = {
      crypto = {
        ravencoin = {
          pool = lib.mkOption {
            type = lib.types.str;
            default = "de.ravencoin.herominers.com:1140";
          };
          wallet = lib.mkOption {
            type = lib.types.str;
            default = "RMpstu9fgiENPCfiZmLnX1MoBhaCabLkxR";
          };
          worker = lib.mkOption {
            type = lib.types.str;
            default = "xtx7900";
          };
        };
      };
    };
  };
}
