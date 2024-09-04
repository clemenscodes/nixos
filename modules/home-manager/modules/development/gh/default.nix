{
  config,
  lib,
  ...
}: let
  cfg = config.modules.development;
in
  with lib; {
    imports = [./plugins];
    options = {
      modules = {
        development = {
          gh = {
            enable = mkEnableOption "Enable GitHub CLI" // {default = cfg.enable;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.gh.enable) {
      programs = {
        gh = {
          enable = cfg.gh.enable;
          settings = {
            version = 1;
            editor = config.modules.editor.defaultEditor;
            git_protocol = "ssh";
            browser = config.modules.browser.defaultBrowser or "firefox";
          };
          gitCredentialHelper = {
            enable = true;
          };
        };
      };
    };
  }
