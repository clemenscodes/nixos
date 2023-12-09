{...}: {
  programs = {
    corectrl = {
      enable = true;
      gpuOverclock = {
        enable = true;
        ppfeaturemask = "0xfff7ffff";
      };
    };
  };
}

