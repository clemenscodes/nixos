{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.io;
  isDesktop = config.modules.display.gui != "headless";
in
  with lib; {
    options = {
      modules = {
        io = {
          sound = {
            enable = mkEnableOption "Enable sound services" // {default = cfg.enable;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.sound.enable) {
      services = {
        pipewire = {
          enable = cfg.sound.enable;
          audio = {
            enable = cfg.sound.enable;
          };
          wireplumber = {
            enable = cfg.sound.enable;
          };
          alsa = {
            enable = cfg.sound.enable;
            support32Bit = cfg.sound.enable;
          };
          pulse = {
            enable = cfg.sound.enable;
          };
          jack = {
            enable = cfg.sound.enable;
          };
        };
      };
      home-manager = mkIf (config.modules.home-manager.enable && isDesktop) {
        users = {
          ${config.modules.users.user} = {
            home = {
              packages = with pkgs; [
                pwvucontrol
              ];
            };
          };
        };
      };
    };
  }
