{
  nixpkgs,
  system,
  config,
  lib,
  ...
}: let
  cfg = config.modules.editor;
  pkgs = import nixpkgs {
    inherit system;
    config = {
      allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) ["vscode"];
    };
  };
  code =
    if cfg.vscode.proprietary
    then pkgs.vscode
    else pkgs.vscodium;
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
            proprietary = mkEnableOption "Use proprietary variant instead of Codium" // {default = false;};
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
          package = code;
          enableExtensionUpdateCheck = true;
          enableUpdateCheck = true;
        };
      };
    };
  }
