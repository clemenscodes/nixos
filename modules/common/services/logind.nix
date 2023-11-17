{ ... }: {
  services = {
    logind = {
      powerKey = "ignore";
      lidSwitch = "lock";
    };
  };
}
