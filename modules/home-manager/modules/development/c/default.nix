{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.development;
in
  with lib; {
    options = {
      modules = {
        development = {
          c = {
            enable = mkEnableOption "Enable C development support" // {default = false;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.c.enable) {
      home = {
        packages = with pkgs; [
          gcc
          cmake
          gnumake
          gdb
          nasm
          clang-tools
        ];
      };
    };
  }
