{inputs,pkgs, ...}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./config
    ./plugins
  ];
  programs = {
    nixvim = {
      enable = true;
      enableMan = true;
      viAlias = true;
      vimAlias = true;
      type = "lua";
      colorscheme = "catppuccin";
    };
  };
}
