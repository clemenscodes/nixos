{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.operations.vps;
in
  with lib; {
    options = {
      modules = {
        operations = {
          vps = {
            hcloud = {
              enable = mkEnableOption "Enable hcloud" // {default = cfg.enable;};
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.hcloud.enable) {
      home = {
        packages = with pkgs; [
          hcloud
        ];
      };
    };
  }
