{...}: {
  programs = {
    nixvim = {
      plugins = {
        gitblame = {
          enable = true;
          displayVirtualText = false;
        };
        which-key = {
          registrations = {
            "<leader>tg" = "Toggle git blame";
          };
        };
      };
      keymaps = [
        {
          action = ":GitBlameToggle<CR>";
          key = "<leader>tg";
          mode = "n";
          options = {
            silent = true;
            desc = "Toggle git blame";
          };
        }
      ];
    };
  };
}
