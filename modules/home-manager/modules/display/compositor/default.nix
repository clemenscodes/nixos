{inputs}: {
  config,
  lib,
  ...
}: let
  cfg = config.modules.display;
in
  with lib; {
    imports = [
      (import ./hyprland {inherit inputs;})
    ];
    options = {
      modules = {
        display = {
          compositor = {
            enable = mkEnableOption "Enable the best compositor" // {default = cfg.enable;};
            defaultCompositor = mkOption {
              type = types.enum ["hyprland"];
              default = "hyprland";
            };
          };
        };
      };
    };
  }
