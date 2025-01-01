{
  inputs,
  lib,
  ...
}: {config, ...}: let
  cfg = config.modules;
in {
  imports = [
    ./base
    (import ./catppuccin {inherit inputs;})
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
