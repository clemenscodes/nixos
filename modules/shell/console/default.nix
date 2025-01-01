{lib, ...}: {config, ...}: let
  cfg = config.modules.shell;
in {
  options = {
    modules = {
      shell = {
        console = {
          enable = lib.mkEnableOption "Enable a neat console configuration" // {default = cfg.enable;};
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.console.enable) {
    console = {
      earlySetup = cfg.console.enable;
      keyMap = config.modules.locale.defaultLocale;
    };
  };
}
