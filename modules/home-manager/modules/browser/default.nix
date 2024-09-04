{inputs}: {
  lib,
  config,
  osConfig,
  ...
}:
with lib; let
  cfg = config.modules;
  isDesktop = osConfig.modules.display.gui != "headless";
in {
  imports = [
    ./chromium
    (import ./firefox {inherit inputs;})
  ];
  options = {
    modules = {
      browser = {
        enable = mkEnableOption "Enables a cool browser" // {default = cfg.enable && isDesktop;};
        defaultBrowser = mkOption {
          type = types.str;
          default =
            if isDesktop
            then "firefox"
            else "echo";
        };
      };
    };
  };
  config = mkIf (cfg.enable && cfg.browser.enable) {
    home = {
      sessionVariables = {
        BROWSER = cfg.browser.defaultBrowser;
      };
    };
  };
}
