{pkgs, ...}: {
  programs = {
    nixvim = {
      extraPackages = with pkgs; [ripgrep fd];
      plugins = {
        telescope = {
          enable = true;
          extensions = {
            fzf-native = {
              enable = true;
              caseMode = "smart_case";
              fuzzy = true;
            };
            project-nvim = {
              enable = true;
            };
          };
          highlightTheme = "catppuccin";
          keymaps = {};
          keymapsSilent = true;
          extraOptions = {};
        };
        which-key = {
          registrations = {
            "<leader>f" = {
              name = "Telescope";
              f = "Find files";
              g = "Live grep";
              p = "Projects";
            };
          };
        };
      };
      keymaps = [
        {
          action = ":Telescope find_files<CR>";
          key = "<leader>ff";
          mode = "n";
          options = {
            silent = true;
            desc = "Find files";
          };
        }
        {
          action = ":Telescope live_grep<CR>";
          key = "<leader>fg";
          mode = "n";
          options = {
            silent = true;
            desc = "Live grep";
          };
        }
        {
          action = ":Telescope projects<CR>";
          key = "<leader>fp";
          mode = "n";
          options = {
            silent = true;
            desc = "Projects";
          };
        }
      ];
    };
  };
}
