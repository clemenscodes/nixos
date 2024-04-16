{...}: {
  programs = {
    nixvim = {
      plugins = {
        mini = {
          modules = {
            animate = {
              cursor = {
                enable = false;
              };
              scroll = {
                enable = true;
              };
              resize = {
                enable = true;
              };
              open = {
                enable = true;
              };
              close = {
                enable = true;
              };
            };
          };
        };
      };
    };
  };
}
