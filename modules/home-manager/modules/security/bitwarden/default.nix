{
  pkgs,
  config,
  osConfig,
  lib,
  ...
}: let
  cfg = config.modules.security;
  bitwardenPackage =
    if osConfig.modules.display.gui == "headless"
    then pkgs.bitwarden-cli
    else pkgs.bitwarden-desktop;
in
  with lib; {
    options = {
      modules = {
        security = {
          bitwarden = {
            enable = mkEnableOption "Enable bitwarden" // {default = false;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.bitwarden.enable) {
      home = {
        packages = [bitwardenPackage];
      };
    };
  }
