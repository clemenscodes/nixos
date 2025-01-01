{
  inputs,
  pkgs,
  lib,
  ...
}: {config, ...}: let
  cfg = config.modules.networking;
in {
  imports = [
    (import ./weechat {inherit inputs pkgs lib;})
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
