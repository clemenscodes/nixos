{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.modules.gaming.wine;
  inherit (config.modules.users) user;
in
  with lib; {
    options = {
      modules = {
        gaming = {
          wine = {
            wc3 = {
              enable = mkEnableOption "Enable wc3" // {default = cfg.enable;};
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.wc3.enable) {
      home-manager = {
        users = {
          ${user} = {
            home = {
              packages = with pkgs; [wineWowPackages.stagingFull];
            };
          };
        };
      };
    };
  }
