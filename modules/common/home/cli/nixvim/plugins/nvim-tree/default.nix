{...}: {
  programs = {
    nixvim = {
      keymaps = [
        {
          action = ":NvimTreeToggle<CR>";
          key = "<leader>e";
          mode = "n";
          options = {
            silent = true;
            desc = "Toggle nvim-tree";
          };
        }
      ];
      plugins = {
        nvim-tree = {
          enable = true;
          autoClose = true;
          autoReloadOnWrite = true;
          disableNetrw = true;
          hijackCursor = true;
          syncRootWithCwd = true;
          respectBufCwd = true;
          reloadOnBufenter = true;
          preferStartupRoot = true;
          updateFocusedFile = {
            enable = true;
            updateRoot = true;
          };
          systemOpen = {
            cmd = "xdg-open";
          };
          diagnostics = {
            enable = true;
            showOnDirs = true;
          };
          filters = {
            gitClean = false;
            dotfiles = false;
          };
          git = {
            ignore = false;
          };
          onAttach = {
            __raw =
              /*
              lua
              */
              ''
                function(bufnr)
                  local api = require("nvim-tree.api")
                  local function opts(desc)
                    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
                  end

                  local function edit_or_open()
                    local node = api.tree.get_node_under_cursor()

                    if node.nodes ~= nil then
                      -- expand or collapse folder
                      api.node.open.edit()
                    else
                      -- open file
                      api.node.open.edit()
                    end
                  end

                  -- open as vsplit on current node
                  local function vsplit_preview()
                    local node = api.tree.get_node_under_cursor()

                    if node.nodes ~= nil then
                      -- expand or collapse folder
                      api.node.open.edit()
                    else
                      -- open file as vsplit
                      api.node.open.vertical()
                    end

                    -- Finally refocus on tree if it was lost
                    api.tree.focus()
                  end
                  api.config.mappings.default_on_attach(bufnr)
                  vim.keymap.set("n", "l", edit_or_open,          opts("Edit Or Open"))
                  vim.keymap.set("n", "L", vsplit_preview,        opts("Vsplit Preview"))
                  vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close folder"))
                  vim.keymap.set("n", "H", api.tree.collapse_all, opts("Collapse All"))
                end
              '';
          };
          view = {
            centralizeSelection = true;
            width = {
              min = 69;
              max = 69;
              padding = 1;
            };
          };
          modified = {
            enable = true;
          };
          extraOptions = {};
        };
        which-key = {
          registrations = {
            "<leader>e" = "Toggle nvim-tree";
          };
        };
      };
    };
  };
}
