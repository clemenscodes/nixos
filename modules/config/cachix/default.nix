{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.config;
in
  with lib; {
    options = {
      modules = {
        config = {
          cachix = {
            enable = mkEnableOption "Enable common cachix options" // {default = cfg.enable;};
            token = mkOption {
              type = types.path;
              default = null;
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.cachix.enable) {
      environment = {
        systemPackages = with pkgs; [cachix];
      };
    };
  }
