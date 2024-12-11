{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.storage;
  rcloneConf = "rclone.conf";
  mountStorage = pkgs.writeShellScriptBin "mount-storage" ''
    ${pkgs.rclone}/bin/rclone \
      --config ~/.config/rclone/${rcloneConf} \
      --vfs-cache-mode writes \
      --ignore-checksum mount \
      --drive-client-id $(${pkgs.bat}/bin/bat ${cfg.rclone.clientId} --style=plain) \
      --drive-client-secret $(${pkgs.bat}/bin/bat ${cfg.rclone.clientSecret} --style=plain) \
      --drive-token $(${pkgs.bat}/bin/bat ${cfg.rclone.token} --style=plain) \
      \"${cfg.rclone.mount}:\" \"${cfg.rclone.storage}\"
  '';
in {
  options = {
    modules = {
      storage = {
        rclone = {
          enable = lib.mkEnableOption "Enable rclone for storage" // {default = false;};
          mount = lib.mkOption {
            type = lib.types.str;
            default = "gdrive";
          };
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
    };
    xdg = {
      configFile = {
        "rclone/${rcloneConf}" = {
          text = ''
            [${cfg.rclone.mount}]
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
              ExecStart = lib.getExe mountStorage;
              ExecStop = "${pkgs.fuse}/bin/fusermount -u %h/${cfg.rclone.storage}/%i";
            };
          };
        };
      };
    };
  };
}
