{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.modules.security;
  inherit (config.modules.users) user;
in
  with lib; {
    options = {
      modules = {
        security = {
          gnupg = {
            enable = mkEnableOption "Enable gnupg" // {default = cfg.enable;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.gnupg.enable) {
      programs = {
        gnupg = {
          agent = {
            inherit (cfg.gnupg) enable;
            enableSSHSupport = cfg.ssh.enable;
          };
        };
      };
      security = {
        pam = {
          services = {
            ${user} = {
              gnupg = {
                inherit (cfg.gnupg) enable;
              };
            };
          };
        };
      };
      systemd = {
        user = {
          sockets = {
            gpg-agent = {
              listenStreams = let
                socketDir =
                  pkgs.runCommand "gnupg-socketdir" {
                    nativeBuildInputs = [pkgs.python3];
                  } ''
                    ${pkgs.python3}/bin/python3 ${import ./gnupgdir.nix {inherit pkgs;}} '/home/${config.modules.users.user}/.local/share/gnupg' > $out
                  '';
              in [
                "" # unset
                "%t/gnupg/${builtins.readFile socketDir}/S.gpg-agent"
              ];
            };
          };
        };
      };
    };
  }
