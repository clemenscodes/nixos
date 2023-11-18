{ pkgs, ... }: {
  services = {
    logind = {
      lidSwitch = "suspend";
      powerKey = "ignore";
    };
  };
  powerManagement = {
    enable = true;
  };
}
