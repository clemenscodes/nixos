{inputs}: {
  system,
  config,
  lib,
  ...
}: let
  cfg = config.modules.development.cardano;
in
  with lib; {
    options = {
      modules = {
        development = {
          cardano = {
            wallet = {
              enable = mkEnableOption "Enable cardano-wallet" // {default = cfg.enable;};
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.wallet.enable) {
      home = {
        packages = with inputs.cardano-wallet.packages.${system}; [
          cardano-wallet
        ];
      };
    };
  }
