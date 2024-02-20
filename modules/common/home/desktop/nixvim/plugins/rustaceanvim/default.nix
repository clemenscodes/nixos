{pkgs, ...}: {
  programs = {
    nixvim = {
      extraPackages = with pkgs; [cargo];
      keymaps = [
        {
          action = ":RustLsp runnables<CR>";
          key = "<leader>frr";
          mode = "n";
          options = {
            desc = "Find rust runnables";
            silent = true;
          };
        }
        {
          action = ":RustLsp testables<CR>";
          key = "<leader>frt";
          mode = "n";
          options = {
            desc = "Find rust testables";
            silent = true;
          };
        }
        {
          action = ":RustLsp testables last<CR>";
          key = "<leader>fra";
          mode = "n";
          options = {
            desc = "Run last rust test";
            silent = true;
          };
        }
      ];
      plugins = {
        rustaceanvim = {
          enable = true;
          tools = {
            executor = "toggleterm";
          };
          extraOptions = {};
        };
        which-key = {
          registrations = {
            "<leader>fr" = {
              name = "+Rust";
              r = "Find rust runnables";
              t = "Find rust testables";
              a = "Run last rust test";
            };
          };
        };
      };
    };
  };
}
