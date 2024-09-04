{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.development;
in
  with lib; {
    options = {
      modules = {
        development = {
          node = {
            enable = mkEnableOption "Enable Node.js support" // {default = false;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.node.enable) {
      home = {
        packages = with pkgs; [nodejs];
      };
    };
  }
