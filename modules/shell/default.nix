{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules;
in {
  imports = [
    ./console
    ./environment
    ./ld
    ./zsh
  ];
  options = {
    modules = {
      shell = {
        enable = lib.mkEnableOption "Enable shell configuration" // {default = cfg.enable;};
        defaultShell = lib.mkOption {
          type = lib.types.enum [pkgs.zsh];
          default = pkgs.zsh;
        };
      };
    };
  };
}
