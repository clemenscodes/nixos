{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.shell;
in
  with lib; {
    options = {
      modules = {
        shell = {
          nvd = {
            enable = mkEnableOption "Enable nix version diffs" // {default = cfg.enable;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.nvd.enable) {
      home = {
        packages = with pkgs; [nvd];
      };
    };
  }
