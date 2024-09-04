{
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
            irssi = {
              enable = mkEnableOption "Enable irssi" // {default = cfg.enable;};
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.irssi.enable) {
      programs = {
        irssi = {
          inherit (cfg.irssi) enable;
          networks = {
            liberachat = {
              nick = "derefd";
              server = {
                address = "irc.libera.chat";
                port = 6697;
                autoConnect = true;
              };
              channels = {
              };
            };
          };
        };
      };
    };
  }
