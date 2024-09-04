{
  config,
  lib,
  ...
}: let
  cfg = config.modules.display;
in
  with lib; {
    imports = [
      ./wayvnc
      ./tigervnc
    ];
    options = {
      modules = {
        display = {
          vnc = {
            enable = mkEnableOption "Enable VNC" // {default = cfg.enable;};
            defaultVNC = mkOption {
              type = types.enum ["wayvnc" "tigervnc"];
              default = "wayvnc";
            };
          };
        };
      };
    };
  }
