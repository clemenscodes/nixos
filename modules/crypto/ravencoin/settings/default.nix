{lib, ...}:
with lib; {
  options = {
    modules = {
      crypto = {
        ravencoin = {
          pool = mkOption {
            type = types.str;
            default = "de.ravencoin.herominers.com:1140";
          };
          wallet = mkOption {
            type = types.str;
            default = "RMpstu9fgiENPCfiZmLnX1MoBhaCabLkxR";
          };
          worker = mkOption {
            type = types.str;
            default = "xtx7900";
          };
        };
      };
    };
  };
}
