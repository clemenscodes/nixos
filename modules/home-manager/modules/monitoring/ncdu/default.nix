{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.monitoring;
in
  with lib; {
    options = {
      modules = {
        monitoring = {
          ncdu = {
            enable = mkEnableOption "Enable ncdu disk usage monitoring" // {default = cfg.enable;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.ncdu.enable) {
      home = {
        packages = with pkgs; [
          ncdu
        ];
      };
    };
  }
