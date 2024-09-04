{
  config,
  lib,
  ...
}: let
  cfg = config.modules.display;
in
  with lib; {
    imports = [
      ./waybar
    ];
    options = {
      modules = {
        display = {
          bar = {
            enable = mkEnableOption "Enable a cool bar" // {default = cfg.enable;};
            defaultBar = mkOption {
              type = types.enum ["waybar"];
              default = "waybar";
            };
          };
        };
      };
    };
  }
