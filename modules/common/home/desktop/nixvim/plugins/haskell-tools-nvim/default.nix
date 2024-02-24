{pkgs, ...}: {
  programs = {
    nixvim = {
      extraPlugins = with pkgs.vimPlugins; [
        haskell-tools-nvim
      ];
      extraPackages = with pkgs.haskellPackages; [
        hoogle
        haskell-debug-adapter
        ghci-dap
        fast-tags
      ];
      extraConfigLuaPost =
        /*
        lua
        */
        ''
          require('telescope').load_extension('ht')
        '';
      plugins = {
        which-key = {
          registrations = {
            "<leader>th" = "Toggle Cabal REPL";
          };
        };
      };
      keymaps = [
        {
          lua = true;
          action =
            /*
            lua
            */
            ''
              function()
                require('haskell-tools').repl.toggle()
              end
            '';
          key = "<leader>th";
          mode = "n";
          options = {
            silent = true;
            desc = "Toggle Cabal REPL";
          };
        }
      ];
    };
  };
}
