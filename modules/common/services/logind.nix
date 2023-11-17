{ ... }: {
  services = {
    logind = {
      powerKey = "ignore";
      lidSwitch = "suspend-then-hibernate";
    };
  };
}
