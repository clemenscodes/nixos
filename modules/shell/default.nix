{
  inputs,
  pkgs,
  lib,
  ...
}: {config, ...}: let
  cfg = config.modules;
in {
  imports = [
    (import ./console {inherit inputs pkgs lib;})
    (import ./environment {inherit inputs pkgs lib;})
    (import ./ld {inherit inputs pkgs lib;})
    (import ./zsh {inherit inputs pkgs lib;})
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
