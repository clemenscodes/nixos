{
  pkgs,
  lib,
  ...
}: let
  lact = "${import ./lact {inherit pkgs lib;}}";
in {
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
            ''${lact}/bin/lact daemon'';
        };
      };
    };
  };
}
