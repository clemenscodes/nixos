{inputs, ...}: {
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
    services = {
      cardano-node = {
        package = pkgs.cardano-node;
      };
    };
    config = mkIf (cfg.enable && cfg.cardanix.enable) {
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
