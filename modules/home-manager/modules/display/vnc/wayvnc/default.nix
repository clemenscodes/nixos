{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.display.vnc;
in
  with lib; {
    options = {
      modules = {
        display = {
          vnc = {
            wayvnc = {
              enable = mkEnableOption "Enable wayvnc" // {default = cfg.enable;};
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.wayvnc.enable) {
      home = {
        packages = with pkgs; [wayvnc];
      };
    };
  }
