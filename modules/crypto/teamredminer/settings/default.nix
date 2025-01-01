{lib, ...}: {...}: {
  options = {
    modules = {
      crypto = {
        teamredminer = {
          wallet = lib.mkOption {
            type = lib.types.str;
            default = "9grgD7e5K5ZK5dMtVnAfedVya2kLPpzzygmfYuiCaKvVeDfEz1q";
          };
          pool = lib.mkOption {
            type = lib.types.str;
            default = "de.ergo.herominers.com:1180";
          };
          rig = lib.mkOption {
            type = lib.types.str;
            default = "xtx7900";
          };
          algorithm = lib.mkOption {
            type = lib.types.str;
            default = "autolykos2";
          };
        };
      };
    };
  };
}
