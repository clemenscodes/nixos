{pkgs, ...}: let
  tex = pkgs.texlive.combine {
    inherit (pkgs.texlive) scheme-full;
  };
in {
  programs = {
    nixvim = {
      globals = {
        maplocalleader = " ";
        vimtex_view_method = "zathura";
      };
      extraPackages = [tex];
      extraPlugins = with pkgs.vimPlugins; [
        vimtex
      ];
    };
  };
}
