{pkgs, ...}: {
  programs = {
    nixvim = {
      extraPackages = with pkgs; [
        cargo
        rustc
        vscode-extensions.vadimcn.vscode-lldb.adapter
      ];
      plugins = {
        rustaceanvim = {
          enable = true;
          dap = {
            autoloadConfigurations = true;
          };
          tools = {
            executor = "toggleterm";
            onInitialized =
              /*
              lua
              */
              ''
                function()
                  vim.notify("successfully initialized rust-analyzer")
                end
              '';
          };
          extraOptions = {};
        };
        which-key = {
          registrations = {
            "<leader>fr" = {
              name = "+Rust";
              r = "Find rust runnables";
              t = "Find rust testables";
              d = "Find rust debuggables";
              a = "Run last rust test";
            };
          };
        };
      };
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
          action = ":RustLsp debuggables<CR>";
          key = "<leader>frd";
          mode = "n";
          options = {
            desc = "Find rust debuggables";
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
    };
  };
}
