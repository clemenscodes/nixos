{...}: {
  programs = {
    nixvim = {
      plugins = {
        luasnip = {
          enable = true;
          extraConfig = {
            enable_autosnippets = true;
          };
        };
      };
    };
  };
}
