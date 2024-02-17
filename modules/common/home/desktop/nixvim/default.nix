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
      type = "lua";
      colorscheme = "catppuccin";
    };
  };
}
