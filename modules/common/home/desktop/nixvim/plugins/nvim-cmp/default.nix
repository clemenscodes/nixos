{...}: {
  programs = {
    nixvim = {
      options = {
        completeopt = "menu,menuone,noinsert";
      };
      plugins = {
        nvim-cmp = {
          enable = true;
          preselect = "Item";
          extraOptions = {};
        };
      };
    };
  };
}
