{inputs, ...}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./config
    ./plugins
  ];
  programs = {
    nixvim = {
      enable = true;
      enableMan = true;
      vimAlias = false;
      viAlias = false;
      wrapRc = true;
      type = "lua";
      colorscheme = "catppuccin";
    };
  };
}
