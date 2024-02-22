{...}: {
  programs = {
    nixvim = {
      extraConfigLuaPost =
        /*
        lua
        */
        ''
          vim.keymap.del({'x', 'o'}, 'x')
          vim.keymap.del({'x', 'o'}, 'X')
        '';
      plugins = {
        leap = {
          enable = true;
        };
      };
    };
  };
}
