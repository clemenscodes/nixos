{
  nixpkgs,
  system,
  lib,
  config,
  ...
}: let
  cfg = config.modules.networking.irc;
  pkgs = import nixpkgs {
    inherit system;
    overlays = [
      (
        self: super: {
          weechat = super.weechat.override {
            configure = {availablePlugins, ...}: {
              scripts = with super.weechatScripts; [
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
        }
      )
    ];
  };
in
  with lib; {
    options = {
      modules = {
        networking = {
          irc = {
            weechat = {
              enable = mkEnableOption "Enable WeeChat" // {default = false;};
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.weechat.enable) {
      environment = {
        systemPackages = with pkgs; [weechat];
      };
      services = {
        weechat = {
          inherit (cfg.weechat) enable;
          binary = "${pkgs.weechat}/bin/weechat";
        };
      };
    };
  }
