{...}: {
  programs = {
    nixvim = {
      keymaps = [
        {
          action = ''
            function()
              if require'luasnip'.expand_or_jumpable() then
                require'luasnip'.expand_or_jump()
              end
            end
          '';
          lua = true;
          key = "<c-k>";
          mode = ["i"];
          options = {
            silent = true;
            desc = "Expand lua snippet";
          };
        }
      ];
      plugins = {
        luasnip = {
          enable = true;
          extraConfig = {
            enable_autosnippets = true;
          };
        };
      };
    };
  };
}
