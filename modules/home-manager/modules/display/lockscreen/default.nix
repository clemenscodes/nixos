{
  config,
  lib,
  ...
}: let
  cfg = config.modules.display;
in
  with lib; {
    imports = [
      ./hyprlock
      ./sway-audio-idle-inhibit
      ./swaylock
      ./swayidle
    ];
    options = {
      modules = {
        display = {
          lockscreen = {
            enable = mkEnableOption "Enable lockscreen" // {default = cfg.enable;};
            defaultLockScreen = mkOption {
              type = types.enum ["hyprlock"];
              default = "hyprlock";
            };
          };
        };
      };
    };
  }
