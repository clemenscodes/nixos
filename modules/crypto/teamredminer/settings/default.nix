{lib, ...}:
with lib; {
  options = {
    modules = {
      crypto = {
        teamredminer = {
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
          algorithm = mkOption {
            type = types.str;
            default = "autolykos2";
          };
        };
      };
    };
  };
}
