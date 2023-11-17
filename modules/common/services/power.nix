{ pkgs, ... }: {
  services = {
    logind = {
      lidSwitch = "suspend-then-hibernate";
      powerKey = "ignore";
    };
  };
  powerManagement = {
    enable = true;
  };
}
