{...}: {
  programs = {
    nixvim = {
      plugins = {
        ts-context-commentstring = {
          enable = true;
        };
      };
    };
  };
}
