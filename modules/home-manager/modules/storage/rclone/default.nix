{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.storage;
  rcloneConf = "rclone.conf";
in {
  options = {
    modules = {
      storage = {
        rclone = {
          enable = lib.mkEnableOption "Enable rclone for storage" // {default = false;};
          storage = lib.mkOption {
            type = lib.types.str;
            default = ".local/share/storage";
          };
          type = lib.mkOption {
            type = lib.types.enum ["drive"];
            default = "drive";
          };
          scope = lib.mkOption {
            type = lib.types.enum ["drive"];
            default = "drive";
          };
          clientId = lib.mkOption {
            type = lib.types.path;
            default = null;
          };
          clientSecret = lib.mkOption {
            type = lib.types.path;
            default = null;
          };
          token = lib.mkOption {
            type = lib.types.path;
            default = null;
          };
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.rclone.enable) {
    home = {
      packages = [
        pkgs.rclone
        pkgs.rclone-browser
      ];
      sessionVariables = {
        RCLONE_DRIVE_CLIENT_ID = "$(${pkgs.bat}/bin/bat ${cfg.rclone.clientId} --style=plain)";
        RCLONE_DRIVE_CLIENT_SECRET = "$(${pkgs.bat}/bin/bat ${cfg.rclone.clientSecret} --style=plain)";
        RCLONE_DRIVE_TOKEN = "$(${pkgs.bat}/bin/bat ${cfg.rclone.token} --style=plain)";
      };
    };
    xdg = {
      configFile = {
        "rclone/${rcloneConf}" = {
          text = ''
            [Google Drive]
            type = ${cfg.rclone.type}
            team_drive =
          '';
        };
      };
    };
    systemd = {
      user = {
        services = {
          rclone = {
            Unit = {
              Description = "Example programmatic mount configuration with nix and home-manager.";
              After = ["network-online.target"];
            };
            Install = {
              WantedBy = ["default.target"];
            };
            Service = {
              Type = "notify";
              ExecStartPre = "/usr/bin/env mkdir -p %h/${cfg.rclone.storage}";
              ExecStart = "${pkgs.rclone}/bin/rclone --config=%h/.config/rclone/${rcloneConf} --vfs-cache-mode writes --ignore-checksum mount \"${cfg.rclone.type}:\" \"${cfg.rclone.storage}\"";
              ExecStop = "${pkgs.fuse}/bin/fusermount -u %h/${cfg.rclone.storage}/%i";
            };
          };
        };
      };
    };

    assertions = [
      {
        assertion = (cfg.rclone.clientId == null) || (cfg.rclone.clientSecret == null) || (cfg.rclone.token == null);
        message = "None of the options clientId, clientSecret and token can be null and must be defined.";
      }
    ];
  };
}
