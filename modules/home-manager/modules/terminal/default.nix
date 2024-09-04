{
  config,
  lib,
  ...
}: let
  cfg = config.modules;
in
  with lib; {
    imports = [
      ./kitty
    ];
    options = {
      modules = {
        terminal = {
          enable = mkEnableOption "Enable a great terminal" // {default = cfg.enable;};
          defaultTerminal = mkOption {
            type = types.str;
            default = "kitty";
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.terminal.enable) {
      home = {
        sessionVariables = {
          TERMINAL = cfg.terminal.defaultTerminal;
        };
      };
    };
  }
