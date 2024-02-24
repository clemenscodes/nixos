{pkgs, ...}: {
  programs = {
    nixvim = {
      extraPlugins = with pkgs.vimPlugins; [haskell-snippets-nvim];
      extraConfigLuaPost =
        /*
        lua
        */
        ''
          local ls = require('luasnip')
          local haskell_snippets = require('haskell-snippets').all
          ls.add_snippets('haskell', haskell_snippets, { key = 'haskell' })
        '';
      plugins = {
        luasnip = {
          enable = true;
          extraConfig = {};
        };
      };
    };
  };
}
