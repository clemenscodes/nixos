{...}: {
  programs = {
    nixvim = {
      plugins = {
        lspsaga = {
          enable = true;
          lightbulb = {
            sign = false;
          };
          extraOptions = {};
        };
      };
    };
  };
}
