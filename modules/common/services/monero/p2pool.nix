{pkgs, ...}: {
  systemd = {
    services = with import ./config.nix; {
      "${p2pool}" = {
        description = "${p2pool} daemon";
        after = ["network.target"];
        wantedBy = ["multi-user.target"];
        serviceConfig = {
          User = "${p2pool}";
          Group = "${p2pool}";
          LogsDirectory = "${p2pool}";
          LogsDirectoryMode = "0710";
          Restart = "always";
          RestartSec = 30;
          SuccessExitStatus = [0 1];
          ExecStart =
            /*
            bash
            */
            ''${pkgs.p2pool}/bin/p2pool --help'';
        };
      };
    };
  };
}
