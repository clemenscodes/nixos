{
  config,
  lib,
  ...
}: let
  cfg = config.modules.databases;
in
  with lib; {
    options = {
      modules = {
        databases = {
          postgres = {
            enable = mkEnableOption "Enable postgres" // {default = false;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.postgres.enable) {
      services.postgresql = {
        enable = true;
        authentication = pkgs.lib.mkOverride 10 ''
          #type database  DBuser  auth-method
          local all       all     trust
        '';
      };
    };
  }
