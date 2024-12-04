{
  inputs,
  pkgs,
  ...
}: {
  config,
  lib,
  system,
  ...
}:
with lib; let
  cfg = config.modules.crypto;
in {
  options = {
    modules = {
      crypto = {
        cardanix = {
          enable = mkEnableOption "Enable cardanix" // {default = false;};
        };
      };
    };
  };
  imports = [
    inputs.cardanix.nixosModules.${system}
  ];
  config = mkIf (cfg.enable && cfg.cardanix.enable) {
    services = {
      cardano-node = {
        package = pkgs.cardano-node;
      };
    };
    cardano = {
      inherit (cfg.cardanix) enable;
      address = {
        inherit (cfg.cardanix) enable;
      };
      node = {
        inherit (cfg.cardanix) enable;
        port = 3001;
      };
      wallet = {
        inherit (cfg.cardanix) enable;
      };
      db-sync = {
        inherit (cfg.cardanix) enable;
      };
      daedalus = {
        inherit (cfg.cardanix) enable;
      };
    };
  };
}
