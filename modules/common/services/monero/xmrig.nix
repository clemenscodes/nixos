{pkgs, ...}: {
  systemd = {
    services = with import ./config.nix; {
      "${xmrig}" = {
        description = "${xmrig} daemon";
        after = ["network.target"];
        wantedBy = ["multi-user.target"];
        serviceConfig = {
          User = "${xmrig}";
          Group = "${xmrig}";
          LogsDirectory = "${xmrig}";
          LogsDirectoryMode = "0710";
          Restart = "always";
          RestartSec = 30;
          SuccessExitStatus = [0 1];
          ExecStart =
            /*
            bash
            */
            ''${pkgs.xmrig}/bin/xmrig --help'';
        };
      };
    };
  };
}
