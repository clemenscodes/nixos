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
          action = ":RustLsp runnables last<CR>";
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
              a = "Run last rust test";
            };
          };
        };
      };
    };
  };
}
