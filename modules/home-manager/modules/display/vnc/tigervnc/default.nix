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
            tigervnc = {
              enable = mkEnableOption "Enable tigervnc" // {default = cfg.enable;};
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.tigervnc.enable) {
      home = {
        packages = with pkgs; [tigervnc];
      };
    };
  }
