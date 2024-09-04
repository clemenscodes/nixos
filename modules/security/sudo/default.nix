{
  config,
  lib,
  ...
}: let
  cfg = config.modules.security;
  user = config.modules.users.user;
in
  with lib; {
    options = {
      modules = {
        security = {
          sudo = {
            noPassword = mkOption {
              type = types.bool;
              default = false;
              description = "Allow user to use sudo without password";
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.sudo.noPassword) {
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
