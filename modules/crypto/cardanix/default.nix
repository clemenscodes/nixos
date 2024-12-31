{
  inputs,
  lib,
  ...
}: {
  config,
  system,
  ...
}: let
  cfg = config.modules.crypto;
in {
  options = {
    modules = {
      crypto = {
        cardanix = {
          enable = lib.mkEnableOption "Enable cardanix" // {default = false;};
        };
      };
    };
  };
  imports = [
    inputs.cardanix.nixosModules.${system}
  ];
  config = lib.mkIf (cfg.enable && cfg.cardanix.enable) {
    cardano = {
      inherit (cfg.cardanix) enable;
      bech32 = {
        inherit (cfg.cardanix) enable;
      };
      address = {
        inherit (cfg.cardanix) enable;
      };
      cli = {
        inherit (cfg.cardanix) enable;
      };
      node = {
        inherit (cfg.cardanix) enable;
        submit-api = {
          inherit (cfg.cardanix) enable;
        };
      };
      wallet = {
        inherit (cfg.cardanix) enable;
      };
      db-sync = {
        inherit (cfg.cardanix) enable;
      };
      daedalus = {
        enable = false;
      };
    };
  };
}
