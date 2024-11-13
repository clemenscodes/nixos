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
    config = mkIf (cfg.enable && cfg.cardanix.enable) {
      cardano = {
        enable = true;
        cli = {
          enable = true;
        };
        node = {
          enable = true;
        };
        wallet = {
          enable = true;
        };
        daedalus = {
          enable = true;
        };
      };
    };
  }
