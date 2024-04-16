{pkgs, ...}: let
  nxls = "${import ./nxls.nix {inherit pkgs;}}";
in {
  programs = {
    nixvim = {
      plugins = {
        lsp = {
          postConfig =
            /*
            lua
            */
            ''
              require('lspconfig')["nxls"].setup({
                cmd = {"${nxls}/bin/nxls", "--stdio"},
                root_dir = require('lspconfig')["util"].root_pattern(".git")
              })
            '';
        };
      };
    };
  };
}
