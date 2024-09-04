{
  config,
  lib,
  ...
}: let
  cfg = config.modules.display;
in
  with lib; {
    imports = [
      ./rofi
    ];
    options = {
      modules = {
        display = {
          launcher = {
            enable = mkEnableOption "Enable launchers" // {default = cfg.enable;};
            defaultLauncher = mkOption {
              type = types.enum ["rofi"];
              default = "rofi";
            };
          };
        };
      };
    };
  }
