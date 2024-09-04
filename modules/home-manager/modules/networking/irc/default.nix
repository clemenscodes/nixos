{
  lib,
  config,
  ...
}: let
  cfg = config.modules.networking;
in
  with lib; {
    imports = [
      ./pidgin
      ./irssi
    ];
    options = {
      modules = {
        networking = {
          irc = {
            enable = mkEnableOption "Enable irc" // {default = cfg.enable;};
          };
        };
      };
    };
  }
