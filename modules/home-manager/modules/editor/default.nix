{inputs}: {
  config,
  lib,
  ...
}: let
  cfg = config.modules;
in
  with lib; {
    imports = [
      ./jetbrains
      (import ./nvim {inherit inputs;})
      ./vscode
      ./zed
    ];
    options = {
      modules = {
        editor = {
          enable = mkEnableOption "Enable the best text editor" // {default = cfg.enable;};
          defaultEditor = mkOption {
            type = types.str;
            default = "nvim";
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.editor.enable) {
      home = {
        sessionVariables = {
          EDITOR = cfg.editor.defaultEditor;
        };
      };
    };
  }
