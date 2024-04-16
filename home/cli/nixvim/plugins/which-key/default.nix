{...}: {
  programs = {
    nixvim = {
      opts = {
        timeout = true;
        timeoutlen = 300;
      };
      plugins = {
        which-key = {
          enable = true;
          ignoreMissing = true;
          registrations = {
            "<Tab>" = "Next buffer";
            "<S-Tab>" = "Previous buffer";
            "<leader>h" = "Clear highlights and search term";
            "<leader>o" = "Close all buffers except current";
            "<leader>t" = {
              name = "+Toggle";
            };
          };
        };
      };
    };
  };
}
