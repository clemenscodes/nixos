{pkgs, ...}: 
let 
  nxls = "${import ./nxls.nix {inherit pkgs;}}";
in
{
  programs = {
    nixvim = {
      extraPackages = with pkgs; [nodejs];
      plugins = {
        lsp = {
          postConfig =
            /*
            lua
            */
            ''
              require('lspconfig')["nxls"].setup({
                cmd = {"${nxls}/bin/nxls", "--stdio"}
              })
            '';
        };
      };
    };
  };
}
