{lib, ...}: {config, ...}: let
  cfg = config.modules;
in {
  options = {
    modules = {
      system = {
        enable = lib.mkEnableOption "Enable system settings" // {default = cfg.enable;};
        defaultVersion = lib.mkOption {
          type = lib.types.str;
          default = lib.versions.majorMinor lib.version;
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.system.enable) {
    system = {
      stateVersion = cfg.system.defaultVersion;
    };
  };
}
