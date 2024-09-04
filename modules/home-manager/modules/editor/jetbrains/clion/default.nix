{
  lib,
  config,
  nixpkgs,
  system,
  ...
}:
with lib; let
  cfg = config.modules.editor.jetbrains;
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
in {
  options = {
    modules = {
      editor = {
        jetbrains = {
          clion = {
            enable = mkEnableOption "Enable CLion" // {default = cfg.enable;};
          };
        };
      };
    };
  };
  config = mkIf (cfg.enable && cfg.clion.enable) {
    home = {
      packages = with pkgs; [
        jetbrains.clion
      ];
    };
  };
}
