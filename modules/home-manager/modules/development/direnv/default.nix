{
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
          direnv = {
            enable = mkEnableOption "Enable direnv support" // {default = cfg.enable;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.direnv.enable) {
      programs = {
        direnv = {
          enable = cfg.direnv.enable;
          enableZshIntegration = config.modules.shell.zsh.enable;
          config = {
            global = {
              warn_timeout = "100h";
              hide_env_diff = true;
            };
          };
          nix-direnv = {
            enable = cfg.direnv.enable;
          };
        };
      };
    };
  }
