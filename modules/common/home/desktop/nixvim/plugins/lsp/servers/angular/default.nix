{...}: {
  programs = {
    nixvim = {
      plugins = {
        lsp = {
          postConfig =
            /*
            lua
            */
            ''
              local lsp = require('lspconfig')
              lsp["angularls"].setup({
                cmd = { "ngserver", "--stdio", "--tsProbeLocations", "", "--ngProbeLocations", "" },
                file_types = { "typescript", "html", "typescriptreact", "typescript.tsx" },
                root_dir = lsp.util.root_pattern(".git"),
                on_new_config = function(new_config, new_root_dir)
                  new_config.cmd = cmd
                end
              })
            '';
        };
      };
    };
  };
}
