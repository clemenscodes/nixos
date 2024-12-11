{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.storage;
  mountGoogleDrive = pkgs.writeShellScriptBin "mount-gdrive" ''
    RCLONE_HOME=$XDG_CONFIG_HOME/rclone

    mkdir -p $HOME/${cfg.rclone.gdrive.storage}
    mkdir -p $RCLONE_HOME

    echo "[${cfg.rclone.gdrive.mount}]" > $RCLONE_HOME/${cfg.rclone.gdrive.config}
    echo "type = drive" >> $RCLONE_HOME/${cfg.rclone.gdrive.config}
    echo "team_drive = " >> $RCLONE_HOME/${cfg.rclone.gdrive.config}

    ${pkgs.rclone}/bin/rclone \
      --config $RCLONE_HOME/${cfg.rclone.gdrive.config} \
      --vfs-cache-mode writes \
      --ignore-checksum mount \
      --drive-scope drive \
      --drive-client-id $(${pkgs.bat}/bin/bat ${cfg.rclone.gdrive.clientId} --style=plain) \
      --drive-client-secret $(${pkgs.bat}/bin/bat ${cfg.rclone.gdrive.clientSecret} --style=plain) \
      --drive-token $(${pkgs.bat}/bin/bat ${cfg.rclone.gdrive.token} --style=plain) \
      ${cfg.rclone.gdrive.mount}: ${cfg.rclone.gdrive.storage} \
      --poll-interval 10m
  '';
in {
  options = {
    modules = {
      storage = {
        rclone = {
          enable = lib.mkEnableOption "Enable rclone for storage" // {default = false;};
          gdrive = {
            enable = lib.mkEnableOption "Enable Google Drive" // {default = false;};
            mount = lib.mkOption {
              type = lib.types.str;
              default = "gdrive";
            };
            config = lib.mkOption {
              type = lib.types.str;
              default = "${cfg.rclone.gdrive.mount}.conf";
            };
            storage = lib.mkOption {
              type = lib.types.str;
              default = ".local/share/storage/${cfg.rclone.gdrive.mount}";
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
  };
  config = lib.mkIf (cfg.enable && cfg.rclone.enable) {
    home = {
      packages = [
        pkgs.rclone
        pkgs.rclone-browser
      ];
      sessionVariables = {
        GDRIVE_STORAGE = "$HOME/${cfg.rclone.gdrive.storage}";
      };
    };
    programs = {
      zsh = {
        shellAliases = lib.mkIf config.modules.shell.zsh.enable {
          storage = "$EXPLORER $XDG_CONFIG_HOME/rclone";
          gdrives = "$EXPLORER $GDRIVE_STORAGE";
        };
      };
    };
    systemd = {
      user = {
        services = {
          rclone-gdrive = lib.mkIf cfg.rclone.gdrive.enable {
            Unit = {
              Description = "${cfg.rclone.gdrive.mount}";
              After = ["network-online.target"];
            };
            Install = {
              WantedBy = ["default.target"];
            };
            Service = {
              Type = "simple";
              ExecStart = lib.getExe mountGoogleDrive;
              ExecStop = "${pkgs.fuse}/bin/fusermount -u %h/${cfg.rclone.gdrive.storage}/%i";
              Restart = "always";
              RestartSec = 10;
            };
          };
        };
      };
    };
  };
}
