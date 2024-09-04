{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.editor;
in
  with lib; {
    options = {
      modules = {
        editor = {
          zed = {
            enable = mkEnableOption "Enable zed" // {default = false;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.zed.enable) {
      home = {
        packages = with pkgs; [zed-editor];
      };
    };
  }
