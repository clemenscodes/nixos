{lib, ...}:
with lib; {
  options = {
    modules = {
      crypto = {
        monero = {
          settings = {
            wallet = mkOption {
              type = types.str;
              default = "49j7AMxXgkBVioejSyBkxBXQSfDDVB9U71vqimeaLrDRBeaK5jc3NH5RNBHTgKSofeGWuCqRRUZTDbRcctVswNXEKSwszEN";
            };
            host = mkOption {
              type = types.str;
              default = "127.0.0.1";
            };
            monero = mkOption {
              type = types.str;
              default = "monero";
            };
            xmrig = mkOption {
              type = types.str;
              default = "xmrig";
            };
            p2pool = mkOption {
              type = types.str;
              default = "p2pool";
            };
            p2pPort = mkOption {
              type = types.int;
              default = 18080;
            };
            p2poolPort = mkOption {
              type = types.int;
              default = 37889;
            };
            p2poolMiniPort = mkOption {
              type = types.int;
              default = 37888;
            };
            p2poolStratumPort = mkOption {
              type = types.int;
              default = 3333;
            };
            p2poolStratumApiPort = mkOption {
              type = types.int;
              default = 3334;
            };
            zmqPort = mkOption {
              type = types.int;
              default = 18083;
            };
            rpcPort = mkOption {
              type = types.int;
              default = 18089;
            };
            rateLimit = mkOption {
              type = types.int;
              default = 128000;
            };
            loglevel = mkOption {
              type = types.int;
              default = 3;
            };
          };
        };
      };
    };
  };
}
