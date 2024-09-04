{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.gpu.amd;
  isDesktop = config.modules.display.gui != "headless";
in
  with lib; {
    options = {
      modules = {
        gpu = {
          amd = {
            lact = {
              enable = mkEnableOption "Enable LACT AMDGPU Control daemon" // {default = cfg.enable;};
            };
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.lact.enable) {
      home-manager = mkIf (config.modules.home-manager.enable && isDesktop) {
        users = {
          ${config.modules.users.user} = {
            home = {
              packages = with pkgs; [lact];
            };
          };
        };
      };
      systemd = {
        services = {
          lactd = {
            description = "AMDGPU Control daemon";
            after = ["multi-user.target"];
            wantedBy = ["graphical.target"];
            serviceConfig = {
              LogsDirectory = "lact";
              LogsDirectoryMode = "0710";
              Restart = "always";
              RestartSec = "30";
              ExecStart =
                /*
                bash
                */
                ''${pkgs.lact}/bin/lact daemon'';
            };
          };
        };
      };
    };
  }
