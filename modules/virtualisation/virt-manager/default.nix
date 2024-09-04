{
  config,
  lib,
  ...
}: let
  cfg = config.modules.virtualisation;
in
  with lib; {
    options = {
      modules = {
        virtualisation = {
          virt-manager = {
            enable = mkEnableOption "Enable virt-manager" // {default = cfg.enable;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.virt-manager.enable) {
      programs = {
        virt-manager = {
          enable = cfg.virt-manager.enable;
        };
      };
    };
  }
