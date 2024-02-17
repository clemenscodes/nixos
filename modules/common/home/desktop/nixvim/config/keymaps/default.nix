{...}: {
  programs = {
    nixvim = {
      keymaps = [
        {
          action = "<c-u>zz";
          key = "<c-u>";
          mode = "n";
          options = {
            silent = true;
            desc = "Navigate up with centered cursor";
          };
        }
        {
          action = "<c-d>zz";
          key = "<c-d>";
          mode = "n";
          options = {
            silent = true;
            desc = "Navigate down with centered cursor";
          };
        }
        {
          action = ":wincmd k<CR>";
          key = "<c-k>";
          mode = "n";
          options = {
            silent = true;
            desc = "Jump to top split";
          };
        }
        {
          action = ":wincmd j<CR>";
          key = "<c-j>";
          mode = "n";
          options = {
            silent = true;
            desc = "Jump to bottom split";
          };
        }
        {
          action = ":wincmd h<CR>";
          key = "<c-h>";
          mode = "n";
          options = {
            silent = true;
            desc = "Jump to left split";
          };
        }
        {
          action = ":wincmd l<CR>";
          key = "<c-l>";
          mode = "n";
          options = {
            silent = true;
            desc = "Jump to right split";
          };
        }
      ];
    };
  };
}
