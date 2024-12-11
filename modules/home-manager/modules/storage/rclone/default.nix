{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.storage;
  mountStorage = pkgs.writeShellScriptBin "mount-storage" ''
    RCLONE_HOME=$XDG_CONFIG_HOME/rclone

    mkdir -p $RCLONE_HOME

    echo "[${cfg.rclone.mount}]" > $RCLONE_HOME/${cfg.rclone.config}
    echo "type = ${cfg.rclone.type}" >> $RCLONE_HOME/${cfg.rclone.config}
    echo "team_drive = " >> $RCLONE_HOME/${cfg.rclone.config}

    ${pkgs.rclone}/bin/rclone \
      --config $RCLONE_HOME/${cfg.rclone.config} \
      --vfs-cache-mode writes \
      --ignore-checksum mount \
      --drive-client-id $(${pkgs.bat}/bin/bat ${cfg.rclone.clientId} --style=plain) \
      --drive-client-secret $(${pkgs.bat}/bin/bat ${cfg.rclone.clientSecret} --style=plain) \
      --drive-token $(${pkgs.bat}/bin/bat ${cfg.rclone.token} --style=plain) \
      --drive-scope ${cfg.rclone.scope} \
      ${cfg.rclone.mount}: ${cfg.rclone.storage} \
      --poll-interval 10m
  '';
in {
  options = {
    modules = {
      storage = {
        rclone = {
          enable = lib.mkEnableOption "Enable rclone for storage" // {default = false;};
          config = lib.mkOption {
            type = lib.types.str;
            default = "rclone.conf";
          };
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
      sessionVariables = {
        STORAGE = "$HOME/${cfg.rclone.storage}";
      };
    };
    programs = {
      zsh = {
        shellAliases = lib.mkIf config.modules.shell.zsh.enable {
          storage = "cd $STORAGE";
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
              Type = "simple";
              ExecStartPre = "/usr/bin/env mkdir -p %h/${cfg.rclone.storage}";
              ExecStart = lib.getExe mountStorage;
              ExecStop = "${pkgs.fuse}/bin/fusermount -u %h/${cfg.rclone.storage}/%i";
              Restart = "always";
              RestartSec = 10;
            };
          };
        };
      };
    };
  };
}
