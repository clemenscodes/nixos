{
  config,
  lib,
  ...
}: let
  cfg = config.modules.security;
  ssh = 22;
in
  with lib; {
    options = {
      modules = {
        security = {
          ssh = {
            enable = mkEnableOption "Enable SSH" // {default = cfg.enable;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.ssh.enable) {
      networking = {
        firewall = {
          allowedTCPPorts = [ssh];
        };
      };
      services = {
        openssh = {
          inherit (cfg.ssh) enable;
          ports = [ssh];
          settings = {
            PermitRootLogin = "prohibit-password";
            PasswordAuthentication = true;
          };
        };
      };
    };
  }
