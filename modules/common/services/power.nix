{pkgs, ...}: {
  services = {
    logind = {
      lidSwitch = "ignore";
      lidSwitchDocked = "ignore";
      powerKey = "ignore";
    };
  };
  powerManagement = {
    enable = true;
  };
}
