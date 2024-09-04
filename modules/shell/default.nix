{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules;
in
  with pkgs;
  with lib; {
    imports = [
      ./console
      ./environment
      ./ld
      ./zsh
    ];
    options = {
      modules = {
        shell = {
          enable = mkEnableOption "Enable shell configuration" // {default = cfg.enable;};
          defaultShell = mkOption {
            type = types.enum [zsh];
            default = zsh;
          };
        };
      };
    };
  }
