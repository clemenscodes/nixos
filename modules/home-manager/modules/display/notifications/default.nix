{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.display;
in
  with lib; {
    imports = [
      ./swaync
    ];
    options = {
      modules = {
        display = {
          notifications = {
            enable = mkEnableOption "Enable notifications" // {default = cfg.enable;};
            defaultNotificationCenter = mkOption {
              type = types.enum ["swaync"];
              default = "swaync";
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.notifications.enable) {
      home = {
        packages = with pkgs; [
          libnotify
        ];
      };
    };
  }
