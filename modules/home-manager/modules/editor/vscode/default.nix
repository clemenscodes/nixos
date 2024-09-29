{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.editor;
  codevim = pkgs.writeShellScriptBin "codevim" ''
    nix run github:clemenscodes/codevim -- "$@"
  '';
in
  with lib; {
    imports = [
      ./keybindings.nix
      ./settings.nix
      ./extensions.nix
      ./launcher.nix
    ];
    options = {
      modules = {
        editor = {
          vscode = {
            enable = mkEnableOption "Enable VSCode" // {default = false;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.vscode.enable) {
      home = {
        packages = [codevim];
      };
      programs = {
        vscode = {
          enable = cfg.vscode.enable;
          package = pkgs.vscodium;
          enableExtensionUpdateCheck = true;
          enableUpdateCheck = true;
        };
      };
    };
  }
