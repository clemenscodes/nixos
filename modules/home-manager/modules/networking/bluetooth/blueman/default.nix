{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.networking.bluetooth;
in
  with lib; {
    options = {
      modules = {
        networking = {
          bluetooth = {
            blueman = {
              enable = mkEnableOption "Enable blueman" // {default = cfg.enable;};
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.blueman.enable) {
      home = {
        packages = with pkgs; [
          blueman
        ];
      };
      services = {
        blueman-applet = {
          enable = cfg.blueman.enable;
        };
      };
    };
  }
