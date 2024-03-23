{...}: {
  programs = {
    nixvim = {
      plugins = {
        lspsaga = {
          enable = false;
          lightbulb = {
            sign = false;
          };
          extraOptions = {};
        };
      };
    };
  };
}
