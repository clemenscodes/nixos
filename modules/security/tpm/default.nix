{
  pkgs,
  lib,
  ...
}: {config, ...}: let
  cfg = config.modules.security;
in {
  options = {
    modules = {
      security = {
        tpm = {
          enable = lib.mkEnableOption "Enable tpm" // {default = cfg.enable;};
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.tpm.enable) {
    environment = {
      systemPackages = [pkgs.tpm2-tools];
    };
    security = {
      tpm2 = {
        inherit (cfg.tpm) enable;
        pkcs11 = {
          inherit (cfg.tpm) enable;
        };
        tctiEnvironment = {
          inherit (cfg.tpm) enable;
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
