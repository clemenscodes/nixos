{
  pkgs,
  lib,
  config,
  ...
}: let
  sshagent = pkgs.writeShellScriptBin "sshagent" ''
    eval "$(${pkgs.openssh}/bin/ssh-agent -s)" && ${pkgs.openssh}/bin/ssh-add
  '';
  cfg = config.modules.security;
in
  with lib; {
    options = {
      modules = {
        security = {
          ssh = {
            enable = mkEnableOption "Enable SSH" // {default = false;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.ssh.enable) {
      home = {
        packages = with pkgs; [
          gnome-keyring
          sshagent
        ];
      };
      services = {
        gnome-keyring = {
          enable = cfg.ssh.enable;
          components = [
            "ssh"
            "secrets"
          ];
        };
        ssh-agent = {
          enable = cfg.ssh.enable;
        };
      };
    };
  }
