{
  lib,
  config,
  ...
}: let
  cfg = config.modules.networking;
in {
  imports = [
    ./weechat
  ];
  options = {
    modules = {
      networking = {
        irc = {
          enable = lib.mkEnableOption "Enable irc" // {default = cfg.enable;};
        };
      };
    };
  };
}
