{...}: {
  programs = {
    nixvim = {
      plugins = {
        rustaceanvim = {
          enable = true;
          tools = {
            executor = "toggleterm";
          };
          extraOptions = {};
        };
      };
    };
  };
}
