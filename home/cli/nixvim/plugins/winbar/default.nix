{...}: {
  programs = {
    nixvim = {
      plugins = {
        barbecue = {
          enable = true;
          attachNavic = true;
        };
        navbuddy = {
          enable = true;
          lsp = {
            autoAttach = true;
          };
        };
        navic = {
          enable = true;
          click = true;
          highlight = true;
          lazyUpdateContext = true;
          lsp = {
            autoAttach = true;
            preference = ["typescript" "html" "tailwind"];
          };
          extraOptions = {};
        };
      };
      keymaps = [
        {
          action = ":Navbuddy<CR>";
          key = "<leader>tn";
          mode = "n";
          options = {
            silent = true;
            desc = "Toggle Navbuddy";
          };
        }
      ];
      plugins = {
        trouble = {
          enable = true;
        };
        which-key = {
          registrations = {
            "<leader>tn" = "Toggle Navbuddy";
          };
        };
      };
    };
  };
}
