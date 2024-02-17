{...}: {
  programs = {
    nixvim = {
      plugins = {
        cursorline = {
          enable = true;
          extraOptions = {
            cursorline = {
              timeout = 0;
            };
            cursorword = {
              enable = false;
              hl = {
                underline = false;
              };
            };
          };
        };
      };
    };
  };
}
