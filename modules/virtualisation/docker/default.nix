{lib, ...}: {config, ...}: let
  cfg = config.modules.virtualisation;
  inherit (config.modules.users) user;
in {
  options = {
    modules = {
      virtualisation = {
        docker = {
          enable = lib.mkEnableOption "Enable docker" // {default = cfg.enable;};
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.docker.enable) {
    virtualisation = {
      docker = {
        inherit (cfg.docker) enable;
      };
    };
    users = {
      users = {
        ${user} = {
          extraGroups = ["docker"];
        };
      };
    };
  };
}
