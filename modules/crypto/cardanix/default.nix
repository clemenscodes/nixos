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
    environment = {
      systemPackages = [inputs.cardano-workbench.packages.${system}.cdwb];
    };
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
