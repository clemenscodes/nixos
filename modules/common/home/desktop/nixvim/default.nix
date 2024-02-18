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
      type = "lua";
      colorscheme = "catppuccin";
    };
  };
}
