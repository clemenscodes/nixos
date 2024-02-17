{...}: {
  programs = {
    nixvim = {
      plugins = {
        cmp-buffer = {
          enable = true;
        };
      };
    };
  };
}
