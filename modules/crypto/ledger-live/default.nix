{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.crypto;
in
  with lib; {
    options = {
      modules = {
        crypto = {
          ledger-live = {
            enable = mkEnableOption "Enable ledger-live" // {default = cfg.enable;};
          };
        };
      };
    };
    config = mkIf (cfg.ledger-live.enable) {
      environment = {
        systemPackages = with pkgs; [ledger-live-desktop];
      };
      hardware = {
        ledger = {
          enable = cfg.ledger-live.enable;
        };
      };
    };
  }
