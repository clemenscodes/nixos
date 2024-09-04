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
          nom = {
            enable = mkEnableOption "Enable the nix output monitor" // {default = cfg.enable;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.nom.enable) {
      home = {
        packages = with pkgs; [nix-output-monitor];
      };
    };
  }
