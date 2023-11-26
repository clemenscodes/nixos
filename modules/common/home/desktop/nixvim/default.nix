{inputs, ...}: {
  imports = [inputs.nixvim.homeManagerModules.nixvim];
  programs = {
    nixvim = {
      enable = true;
      enableMan = true;
      type = "lua";
      colorscheme = "catppuccin";
      options = {};
      globals = {};
      autoCmd = [];
      autoGroups = {};
      editorconfig = {
        enable = true;
        properties = {};
      };
      luaLoader = {
        enable = false;
      };
      maps = {
        command = {};
        insert = {};
        insertCommand = {};
        lang = {};
        normal = {};
        normalVisualOp = {};
        operator = {};
        select = {};
        visual = {};
        visualOnly = {};
      };
      userCommands = {};
      clipboard = {
        register = "unnamedplus";
        providers = {
          wl-copy = {
            enable = true;
          };
        };
      };
      colorschemes = {
        catppuccin = {
          enable = true;
          flavour = "macchiato";
          integrations = {};
          styles = {};
        };
      };
      keymaps = [];
      plugins = {
        which-key = {
          enable = true;
        };
      };
      extraPlugins = [];
      extraPackages = [];
      extraConfigLuaPre = ''
      '';
      extraConfigLua = ''
      '';
      extraConfigLuaPost = ''
      '';
      extraFiles = {};
      extraLuaPackages = _: [];
    };
  };
}
