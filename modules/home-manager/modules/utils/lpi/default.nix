{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: let
  lpi = inputs.lpi.packages.${pkgs.system}.default;
  cfg = config.modules.utils;
in
  with lib; {
    options = {
      modules = {
        utils = {
          lpi = {
            enable = mkEnableOption "Enable lpi to load project information" // {default = cfg.enable;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.lpi.enable) {
      home = {
        packages = with pkgs; [moon lpi];
      };
    };
  }
