{
  pkgs,
  lib,
  ...
}: {config, ...}: let
  cfg = config.modules.networking.irc;
  weechat = weechat.override {
    configure = {...}: {
      scripts = with pkgs.weechatScripts; [
        weechat-notify-send
        weechat-grep
        weechat-go
        weechat-autosort
        url_hint
        multiline
        highmon
        edit
      ];
    };
  };
in {
  options = {
    modules = {
      networking = {
        irc = {
          weechat = {
            enable = lib.mkEnableOption "Enable WeeChat" // {default = false;};
          };
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.weechat.enable) {
    environment = {
      systemPackages = [weechat];
    };
    services = {
      weechat = {
        inherit (cfg.weechat) enable;
        binary = "${weechat}/bin/weechat";
      };
    };
  };
}
