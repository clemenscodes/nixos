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
      inherit (cfg.docs) enable;
      nixos = {
        inherit (cfg.docs) enable;
        includeAllModules = cfg.docs.enable;
        options = {
          warningsAreErrors = false;
        };
      };
      info = {
        inherit (cfg.docs) enable;
      };
      doc = {
        inherit (cfg.docs) enable;
      };
      dev = {
        inherit (cfg.docs) enable;
      };
      man = {
        inherit (cfg.docs) enable;
        generateCaches = cfg.docs.enable;
      };
    };
  };
}
