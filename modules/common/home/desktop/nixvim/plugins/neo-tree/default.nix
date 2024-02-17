{pkgs,...}: {
  programs = {
    nixvim = {
      keymaps = [
        {
          action = ":Neotree toggle<CR>";
          key = "<leader>e";
          mode = "n";
          options = {
            silent = true;
            desc = "Toggle neo-tree";
          };
        }
      ];
      plugins = {
        neo-tree = {
          enable = true;
          autoCleanAfterSessionRestore = true;
          closeIfLastWindow = true;
          extraOptions = {};
        };
        which-key = {
          registrations = {
            "<leader>e" = "Toggle neo-tree";
          };
        };
      };
    };
  };
}
