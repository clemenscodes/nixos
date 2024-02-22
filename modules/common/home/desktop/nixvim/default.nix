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
      vimAlias = true;
      viAlias = true;
      wrapRc = true;
      type = "lua";
      colorscheme = "catppuccin";
    };
  };
}
