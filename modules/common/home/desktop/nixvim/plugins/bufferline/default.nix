{...}: {
  programs = {
    nixvim = {
      plugins = {
        bufferline = {
          enable = true;
          closeIcon = "";
          bufferCloseIcon = "";
          diagnostics = "nvim_lsp";
          hover = {
            enabled = true;
          };
          extraOptions = {};
        };
      };
    };
  };
}
