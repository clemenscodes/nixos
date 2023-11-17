{ pkgs, ... }: 
let
  hibernateEnvironment = {
    HIBERNATE_SECONDS = "3600";
    HIBERNATE_LOCK = "/var/run/autohibernate.lock";
  };
in {
  services = {
    logind = {
      lidSwitch = "ignore";
      powerKey = "ignore";
    };
    acpid = {
      enable = true;
      lidEventCommands = ''
        export PATH=$PATH:/run/current-system/sw/bin

        lid_state=$(cat /proc/acpi/button/lid/LID0/state | awk '{print $NF}')
        if [ $lid_state = "closed" ]; then
            ${pkgs.systemd}/bin/systemctl suspend-then-hibernate && ${pkgs.swaylock}/bin/swaylock -f
        fi
      '';
      powerEventCommands = ''
        ${pkgs.systemd}/bin/systemctl suspend-then-hibernate
      '';
    };
  };
  powerManagement = {
    enable = true;
  };
}
