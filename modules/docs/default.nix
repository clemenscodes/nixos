{lib, ...}: {config, ...}: let
  cfg = config.modules.docs;
in {
  options = {
    modules = {
      docs = {
        enable = lib.mkEnableOption "Enable documentation for NixOS" // {default = false;};
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.docs.enable) {
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
