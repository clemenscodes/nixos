{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.modules.networking.irc;
in
  with lib; {
    options = {
      modules = {
        networking = {
          irc = {
            pidgin = {
              enable = mkEnableOption "Enable pidgin" // {default = cfg.enable;};
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.pidgin.enable) {
      programs = {
        pidgin = {
          inherit (cfg.pidgin) enable;
          plugins = with pkgs.pidginPackages; [
            pidgin-otr
            purple-discord
            pidgin-indicator
          ];
        };
      };
    };
  }
