{...}: {
  programs = {
    nixvim = {
      plugins = {
        vim-bbye = {
          enable = true;
          keymapsSilent = true;
          keymaps = {
            bdelete = "<leader>q";
            bwipeout = "<leader>w";
          };
        };
        which-key = {
          registrations = {
            "<leader>q" = "Close current buffer";
            "<leader>w" = "Wipe current buffer";
          };
        };
      };
    };
  };
}
