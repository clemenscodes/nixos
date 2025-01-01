{
  pkgs,
  lib,
  ...
}: {config, ...}: let
  cfg = config.modules.crypto;
in {
  options = {
    modules = {
      crypto = {
        ledger-live = {
          enable = lib.mkEnableOption "Enable ledger-live" // {default = cfg.enable;};
        };
      };
    };
  };
  config = lib.mkIf (cfg.ledger-live.enable) {
    environment = {
      systemPackages = [pkgs.ledger-live-desktop];
    };
    hardware = {
      ledger = {
        inherit (cfg.ledger-live) enable;
      };
    };
  };
}
