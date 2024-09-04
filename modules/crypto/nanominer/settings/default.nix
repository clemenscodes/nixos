{lib, ...}:
with lib; {
  options = {
    modules = {
      crypto = {
        nanominer = {
          wallet = mkOption {
            type = types.str;
            default = "9grgD7e5K5ZK5dMtVnAfedVya2kLPpzzygmfYuiCaKvVeDfEz1q";
          };
          pool = mkOption {
            type = types.str;
            default = "de.ergo.herominers.com:1180";
          };
          rig = mkOption {
            type = types.str;
            default = "xtx7900";
          };
          coin = mkOption {
            type = types.str;
            default = "ergo";
          };
          email = mkOption {
            type = types.str;
          };
          ethmanPort = mkOption {
            type = types.str;
            default = "3335";
          };
        };
      };
    };
  };
}
