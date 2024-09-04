{
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
          zoxide = {
            enable = mkEnableOption "Enable zoxide" // {default = cfg.enable;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.zoxide.enable) {
      programs = {
        zoxide = {
          enable = cfg.zoxide.enable;
          enableZshIntegration = cfg.zsh.enable;
        };
      };
    };
  }
