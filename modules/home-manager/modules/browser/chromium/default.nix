{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.browser;
in {
  options = {
    modules = {
      browser = {
        chromium = {
          enable = mkEnableOption "Enable chromium" // {default = cfg.enable;};
        };
      };
    };
  };
  config = mkIf (cfg.enable && cfg.chromium.enable) {
    programs = {
      chromium = {
        enable = cfg.chromium.enable;
        package = pkgs.brave;
        commandLineArgs = [
          "--enable-features=UseOzonePlatform"
          "--ozone-platform=wayland"
        ];
        extensions = [
          {
            id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; # ublock origin
          }
          {
            id = "nngceckbapebfimnlniiiahkandclblb"; # bitwarden
          }
        ];
      };
    };
  };
}
