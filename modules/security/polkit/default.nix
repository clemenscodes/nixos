{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.security;
  isDesktop = config.modules.display.gui != "headless";
  polkitagent = import ./polkitagent {inherit pkgs;};
in {
  options = {
    modules = {
      security = {
        polkit = {
          enable = lib.mkEnableOption "Enable policy kit" // {default = cfg.enable && isDesktop;};
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.polkit.enable && isDesktop) {
    environment = {
      systemPackages = [polkitagent];
    };
    security = {
      polkit = {
        inherit (cfg.polkit) enable;
      };
    };
  };
}
