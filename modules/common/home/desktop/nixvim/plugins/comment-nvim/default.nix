{...}: {
  programs = {
    nixvim = {
      plugins = {
        comment-nvim = {
          enable = true;
          sticky = true;
          preHook =
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
}
