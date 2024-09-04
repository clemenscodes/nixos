{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.modules.shell;
in
  with lib; {
    options = {
      modules = {
        shell = {
          environment = {
            enable = mkEnableOption "Enable basic environment settings" // {default = cfg.enable;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.environment.enable) {
      environment = {
        localBinInPath = true;
        homeBinInPath = true;
        systemPackages = with pkgs; [vim];
      };
    };
  }
