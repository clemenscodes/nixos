{
  pkgs,
  lib,
  ...
}: {config, ...}: let
  cfg = config.modules.gpu.amd;
  isDesktop = config.modules.display.gui != "headless";
in {
  options = {
    modules = {
      gpu = {
        amd = {
          lact = {
            enable = lib.mkEnableOption "Enable LACT AMDGPU Control daemon" // {default = cfg.enable;};
          };
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.lact.enable) {
    home-manager = lib.mkIf (config.modules.home-manager.enable && isDesktop) {
      users = {
        ${config.modules.users.user} = {
          home = {
            packages = [pkgs.lact];
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
