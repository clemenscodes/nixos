{...}: {
  programs = {
    nixvim = {
      plugins = {
        cmp-path = {
          enable = true;
        };
      };
    };
  };
}
