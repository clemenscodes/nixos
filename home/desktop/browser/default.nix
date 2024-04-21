{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.desktop.browser;
in {
  options = {
    modules = {
      desktop = {
        browser = {
          enable = mkEnableOption "Enables a browser" // {default = true;};
        };
      };
    };
  };
  config = mkIf cfg.enable {
    programs = {
      chromium = {
        enable = true;
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
