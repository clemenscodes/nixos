{
  lib,
  config,
  ...
}: let
  cfg = config.modules.docs;
in
  with lib; {
    options = {
      modules = {
        docs = {
          enable = mkEnableOption "Enable documentation for NixOS" // {default = false;};
        };
      };
    };
    config = mkIf (cfg.enable && cfg.docs.enable) {
      documentation = {
        enable = true;
        nixos = {
          enable = true;
          includeAllModules = true;
          options = {
            warningsAreErrors = false;
          };
        };
        info = {
          enable = true;
        };
        doc = {
          enable = true;
        };
        dev = {
          enable = true;
        };
        man = {
          enable = true;
          generateCaches = true;
        };
      };
    };
  }
