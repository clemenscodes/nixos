{lib, ...}: {...}: {
  options = {
    modules = {
      crypto = {
        monero = {
          settings = {
            wallet = lib.mkOption {
              type = lib.types.str;
              default = "49j7AMxXgkBVioejSyBkxBXQSfDDVB9U71vqimeaLrDRBeaK5jc3NH5RNBHTgKSofeGWuCqRRUZTDbRcctVswNXEKSwszEN";
            };
            host = lib.mkOption {
              type = lib.types.str;
              default = "127.0.0.1";
            };
            monero = lib.mkOption {
              type = lib.types.str;
              default = "monero";
            };
            xmrig = lib.mkOption {
              type = lib.types.str;
              default = "xmrig";
            };
            p2pool = lib.mkOption {
              type = lib.types.str;
              default = "p2pool";
            };
            p2pPort = lib.mkOption {
              type = lib.types.int;
              default = 18080;
            };
            p2poolPort = lib.mkOption {
              type = lib.types.int;
              default = 37889;
            };
            p2poolMiniPort = lib.mkOption {
              type = lib.types.int;
              default = 37888;
            };
            p2poolStratumPort = lib.mkOption {
              type = lib.types.int;
              default = 3333;
            };
            p2poolStratumApiPort = lib.mkOption {
              type = lib.types.int;
              default = 3334;
            };
            zmqPort = lib.mkOption {
              type = lib.types.int;
              default = 18083;
            };
            rpcPort = lib.mkOption {
              type = lib.types.int;
              default = 18089;
            };
            rateLimit = lib.mkOption {
              type = lib.types.int;
              default = 128000;
            };
            loglevel = lib.mkOption {
              type = lib.types.int;
              default = 3;
            };
          };
        };
      };
    };
  };
}
