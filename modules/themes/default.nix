{
  inputs,
  pkgs,
  lib,
  ...
}: {config, ...}: let
  cfg = config.modules;
in {
  imports = [
    (import ./base {inherit inputs pkgs lib;})
    (import ./catppuccin {inherit inputs pkgs lib;})
  ];
  options = {
    modules = {
      themes = {
        enable = lib.mkEnableOption "Enable slick themes" // {default = cfg.enable;};
        defaultTheme = lib.mkOption {
          type = lib.types.enum ["catppuccin" "base"];
          default = "catppuccin";
        };
      };
    };
  };
}
