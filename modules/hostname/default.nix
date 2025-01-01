{lib, ...}: {config, ...}: let
  cfg = config.modules;
in {
  options = {
    modules = {
      hostname = {
        enable = lib.mkEnableOption "Enable hostname" // {default = cfg.enable;};
        defaultHostname = lib.mkOption {
          type = lib.types.str;
          default = "cymenix";
        };
      };
    };
  };
}
