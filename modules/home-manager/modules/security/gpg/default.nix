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
          gpg = {
            enable = mkEnableOption "Enable GPG support" // {default = false;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.gpg.enable) {
      services = {
        gpg-agent = {
          enable = cfg.gpg.enable;
          enableSshSupport = cfg.ssh.enable;
          enableZshIntegration = config.modules.shell.zsh.enable;
          pinentryPackage = pkgs.pinentry-gnome3;
        };
      };
      programs = {
        gpg = {
          enable = cfg.gpg.enable;
          homedir = "${config.xdg.configHome}/gnupg";
        };
      };
    };
  }
