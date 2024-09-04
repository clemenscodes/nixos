{
  config,
  lib,
  ...
}: let
  cfg = config.modules;
in
  with lib; {
    imports = [
      ./dolphin
      ./lf
      ./yazi
    ];
    options = {
      modules = {
        explorer = {
          enable = mkEnableOption "Enable a file explorer" // {default = cfg.enable;};
          defaultExplorer = mkOption {
            type = types.enum ["lf" "yazi"];
            default = "yazi";
          };
        };
      };
    };
  }
