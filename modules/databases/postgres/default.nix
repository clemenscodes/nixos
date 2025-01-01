{lib, ...}: {config, ...}: let
  cfg = config.modules.databases;
in {
  options = {
    modules = {
      databases = {
        postgres = {
          enable = lib.mkEnableOption "Enable postgres" // {default = false;};
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.postgres.enable) {
    services = {
      postgresql = {
        enable = true;
        authentication = lib.mkOverride 10 ''
          #type database  DBuser  auth-method
          local all       all     trust
        '';
      };
    };
  };
}
