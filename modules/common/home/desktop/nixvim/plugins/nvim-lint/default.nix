{pkgs, ...}: {
  programs = {
    nixvim = {
      extraPackages = with pkgs; [eslint_d];
      plugins = {
        nvim-lint = {
          enable = true;
          extraOptions = {};
          lintersByFt = {
            javascript = ["eslint_d"];
            typescript = ["eslint_d"];
            javascriptreact = ["eslint_d"];
            typescriptreact = ["eslint_d"];
          };
        };
      };
    };
  };
}
