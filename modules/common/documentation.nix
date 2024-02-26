{...}: {
  documentation = {
    enable = true;
    nixos = {
      enable = true;
      includeAllModules = true;
      options = {
        warningsAreErrors = false;
      };
    };
    info = {
      enable = true;
    };
    doc = {
      enable = true;
    };
    dev = {
      enable = true;
    };
    man = {
      enable = true;
      generateCaches = true;
    };
  };
}
