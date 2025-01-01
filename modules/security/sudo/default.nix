{lib, ...}: {config, ...}: let
  cfg = config.modules.security;
  user = config.modules.users.user;
in {
  options = {
    modules = {
      security = {
        sudo = {
          noPassword = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "Allow user to use sudo without password";
          };
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.sudo.noPassword) {
    security = {
      sudo = {
        extraRules = [
          {
            users = [user];
            commands = [
              {
                command = "ALL";
                options = ["NOPASSWD" "SETENV"];
              }
            ];
          }
        ];
      };
    };
  };
}
