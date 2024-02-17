{pkgs, ...}: {
  programs = {
    nixvim = {
      keymaps = [
        {
          action = ":NvimTreeToggle<CR>";
          key = "<leader>e";
          mode = "n";
          options = {
            silent = true;
            desc = "Toggle nvim-tree";
          };
        }
      ];
      plugins = {
        nvim-tree = {
          enable = true;
          autoClose = true;
          autoReloadOnWrite = true;
          disableNetrw = true;
          hijackCursor = true;
          syncRootWithCwd = true;
          respectBufCwd = true;
          reloadOnBufenter = true;
          preferStartupRoot = true;
          updateFocusedFile = {
            enable = true;
            updateRoot = true;
          };
          extraOptions = {};
        };
        which-key = {
          registrations = {
            "<leader>e" = "Toggle nvim-tree";
          };
        };
      };
    };
  };
}
