{
  inputs,
  pkgs,
  lib,
  ...
}: {config, ...}: let
  cfg = config.modules.gaming;
  umu = inputs.umu.packages.${pkgs.system}.umu.override {
    version = "${inputs.umu.shortRev}";
  };
in {
  options = {
    modules = {
      gaming = {
        umu = {
          enable = lib.mkEnableOption "Enable umu" // {default = false;};
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.umu.enable) {
    environment = {
      systemPackages = [umu];
    };
  };
}
