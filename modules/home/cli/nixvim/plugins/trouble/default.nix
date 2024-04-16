{...}: {
  programs = {
    nixvim = {
      keymaps = [
        {
          action = ":TroubleToggle<CR>";
          key = "<leader>tt";
          mode = "n";
          options = {
            silent = true;
            desc = "Toggle trouble";
          };
        }
      ];
      plugins = {
        trouble = {
          enable = true;
        };
        which-key = {
          registrations = {
            "<leader>tt" = "Toggle trouble";
          };
        };
      };
    };
  };
}
