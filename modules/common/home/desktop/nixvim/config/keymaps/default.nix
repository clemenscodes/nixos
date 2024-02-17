{...}: {
  programs = {
    nixvim = {
      keymaps = [
        {
          action = ":wincmd k<CR>";
          key = "<c-k>";
          mode = "n";
          options = {
            silent = true;
          };
        }
        {
          action = ":wincmd j<CR>";
          key = "<c-j>";
          mode = "n";
          options = {
            silent = true;
          };
        }
        {
          action = ":wincmd h<CR>";
          key = "<c-h>";
          mode = "n";
          options = {
            silent = true;
          };
        }
        {
          action = ":wincmd l<CR>";
          key = "<c-l>";
          mode = "n";
          options = {
            silent = true;
          };
        }
      ];
    };
  };
}
