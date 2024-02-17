{...}: {
  programs = {
    nixvim = {
      keymaps = [
        {
          action = ":ToggleTerm<CR>";
          key = "<leader>tt";
          mode = "n";
          options = {
            silent = true;
            desc = "Toggle terminal";
          };
        }
      ];
      plugins = {
        toggleterm = {
          enable = true;
          direction = "float";
        };
        which-key = {
          registrations = {
            "<leader>t" = {
              name = "+Terminal";
              t = "Toggle terminal";
            };
          };
        };
      };
    };
  };
}
