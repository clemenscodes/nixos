{
  config,
  lib,
  ...
}: let
  cfg = config.modules.development.gh;
in
  with lib; {
    imports = [./gh-dash];
    options = {
      modules = {
        development = {
          gh = {
            plugins = {
              enable = mkEnableOption "Enable GitHub CLI plugins" // {default = cfg.enable;};
            };
          };
        };
      };
    };
  }
