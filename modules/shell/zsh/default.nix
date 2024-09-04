{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.shell;
in
  with lib; {
    options = {
      modules = {
        shell = {
          zsh = {
            enable = mkEnableOption "Enable zsh" // {default = cfg.enable;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.zsh.enable) {
      programs = {
        zsh = {
          enable = cfg.zsh.enable;
        };
      };
      environment = {
        shells = with pkgs; [zsh];
      };
    };
  }
