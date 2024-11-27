{inputs, ...}: {
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.modules.gaming;
  umu = inputs.umu.packages.${pkgs.system}.umu.override {
    version = "${inputs.umu.shortRev}";
  };
in
  with lib; {
    options = {
      modules = {
        gaming = {
          umu = {
            enable = mkEnableOption "Enable umu" // {default = cfg.enable;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.umu.enable) {
      environment = {
        systemPackages = [umu];
      };
    };
  }
