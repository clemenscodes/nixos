{
  config,
  lib,
  ...
}: let
  cfg = config.modules.boot.themes;
in
  with lib; {
    options = {
      modules = {
        boot = {
          themes = {
            catppuccin = {
              enable = mkEnableOption "Enable bootloader catppuccin theme" // {default = cfg.enable;};
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.catppuccin.enable) {
      boot = {
        loader = {
          grub = {
            catppuccin = mkIf (config.modules.themes.catppuccin.enable) {
              inherit (config.modules.themes.catppuccin) enable flavor;
            };
          };
        };
      };
    };
  }
