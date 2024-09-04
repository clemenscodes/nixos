{
  config,
  lib,
  ...
}: let
  cfg = config.modules.boot;
  isDesktop = config.modules.display.gui != "headless";
in
  with lib; {
    imports = [
      ./catppuccin
    ];
    options = {
      modules = {
        boot = {
          themes = {
            enable = mkEnableOption "Enable bootloader themes" // {default = cfg.enable && isDesktop;};
          };
        };
      };
    };
  }
