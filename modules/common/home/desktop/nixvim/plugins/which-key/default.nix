{...}: {
  programs = {
    nixvim = {
      options = {
        timeout = true;
        timeoutlen = 300;
      };
      plugins = {
        which-key = {
          enable = true;
          ignoreMissing = true;
        };
      };
    };
  };
}
