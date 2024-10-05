{inputs}: {
  osConfig,
  config,
  lib,
  ...
}: let
  cfg = config.modules;
  osCfg = osConfig.modules.home-manager;
  user = osConfig.modules.users.user;
in
  with lib; {
    imports = [
      (import ./browser {inherit inputs;})
      (import ./development {inherit inputs;})
      (import ./display {inherit inputs;})
      (import ./editor {inherit inputs;})
      ./explorer
      ./fonts
      (import ./gaming {inherit inputs;})
      ./media
      ./monitoring
      ./networking
      ./operations
      ./organization
      (import ./security {inherit inputs;})
      ./shell
      ./terminal
      ./utils
      ./xdg
    ];
    options = {
      modules = {
        enable = mkEnableOption "Enable home-manager modules" // {default = osCfg.enable;};
      };
    };
    config = mkIf (cfg.enable && osCfg.enable) {
      programs = {
        home-manager = {
          enable = osCfg.enable && cfg.enable;
        };
      };
      home = {
        inherit (osConfig.system) stateVersion;
        keyboard = {
          layout = osConfig.modules.locale.defaultLocale;
        };
        username = user;
        homeDirectory = "/home/${user}";
        sessionPath = ["${config.home.homeDirectory}/.local/bin"];
        file = {
          ".local/src/README.md" = {
            text = ''
              # Source Code / Packages

              - This is the home for all external source code and projects
              - run `rr` to cd into this directory
            '';
          };
        };
      };
    };
  }
