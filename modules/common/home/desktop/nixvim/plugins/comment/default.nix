{...}: {
  programs = {
    nixvim = {
      plugins = {
        comment = {
          enable = true;
          settings = {
            sticky = true;
            pre_hook =
              /*
              lua
              */
              ''
                require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
              '';
          };
        };
      };
    };
  };
}
