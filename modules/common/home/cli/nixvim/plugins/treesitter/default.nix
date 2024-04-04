{...}: {
  imports = [./filetypes];
  programs = {
    nixvim = {
      plugins = {
        treesitter = {
          enable = true;
          nixvimInjections = true;
          nixGrammars = true;
        };
      };
    };
  };
}
