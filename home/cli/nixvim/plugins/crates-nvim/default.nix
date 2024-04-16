{...}: {
  programs = {
    nixvim = {
      plugins = {
        crates-nvim = {
          enable = true;
          extraOptions = {};
        };
      };
    };
  };
}
