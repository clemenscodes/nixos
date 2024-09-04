{
  config,
  lib,
  ...
}: let
  cfg = config.modules.display;
in
  with lib; {
    imports = [
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
              type = types.enum ["swaylock"];
              default = "swaylock";
            };
          };
        };
      };
    };
  }
