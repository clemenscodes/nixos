{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.security;
in
  with lib; {
    options = {
      modules = {
        security = {
          tpm = {
            enable = mkEnableOption "Enable tpm" // {default = cfg.enable;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.tpm.enable) {
      environment = {
        systemPackages = with pkgs; [tpm2-tools];
      };
      security = {
        tpm2 = {
          enable = cfg.tpm.enable;
          pkcs11 = {
            enable = true;
          };
          tctiEnvironment = {
            enable = true;
          };
        };
      };
      users = {
        users = {
          "${config.modules.users.user}" = {
            extraGroups = ["tss"];
          };
        };
      };
    };
  }
