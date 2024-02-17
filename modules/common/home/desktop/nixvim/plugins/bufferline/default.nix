{...}: {
  programs = {
    nixvim = {
      plugins = {
        bufferline = {
          enable = true;
          closeIcon = "";
          alwaysShowBufferline = false;
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
