{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.networking;
in
  with lib; {
    options = {
      modules = {
        networking = {
          nm = {
            enable = mkEnableOption "Enable network-manager applet" // {default = cfg.enable;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.nm.enable) {
      home = {
        packages = with pkgs; [
          networkmanagerapplet
        ];
      };
      services = {
        network-manager-applet = {
          enable = cfg.nm.enable;
        };
      };
    };
  }
