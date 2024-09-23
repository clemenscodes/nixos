{
  lib,
  config,
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
