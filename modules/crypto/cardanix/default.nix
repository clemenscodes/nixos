{inputs, ...}: {
  config,
  lib,
  system,
  ...
}: let
  cfg = config.modules.crypto;
  inherit (cfg.cardanix) enable;
in
  with lib; {
    options = {
      modules = {
        crypto = {
          cardanix = {
            enable = mkEnableOption "Enable cardanix" // {default = false;};
          };
        };
      };
    };
    imports = [inputs.cardanix.nixosModules.${system}];
    config = mkIf (cfg.enable && cfg.cardanix.enable) {
      cardano = {
        inherit enable;
        cardano-cli = {
          inherit enable;
        };
        cardano-node = {
          inherit enable;
        };
        cardano-wallet = {
          inherit enable;
        };
        daedalus = {
          inherit enable;
        };
      };
    };
  }
