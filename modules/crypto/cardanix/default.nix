{inputs, pkgs, ...}: {
  config,
  lib,
  system,
  ...
}: let
  cfg = config.modules.crypto;
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
      services = {
        cardano-node = {
          package = pkgs.cardano-node;
        };
      };
      cardano = {
        enable = true;
        address = {
          enable = true;
        };
        node = {
          enable = true;
        };
        wallet = {
          enable = true;
        };
        db-sync = {
          enable = true;
        };
        daedalus = {
          enable = true;
        };
      };
    };
  }
