{
  config,
  lib,
  ...
}: let
  cfg = config.modules.development.gh.plugins;
in {
  options = {
    modules = {
      development = {
        gh = {
          plugins = {
            gh-dash = {
              enable = lib.mkEnableOption "Enable the GitHub CLI dashboard plugin" // {default = cfg.enable;};
            };
          };
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.gh-dash.enable) {
    programs = {
      gh-dash = {
        enable = cfg.gh-dash.enable;
      };
    };
  };
}
