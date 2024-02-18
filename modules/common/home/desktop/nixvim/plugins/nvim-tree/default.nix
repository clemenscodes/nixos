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
          onAttach = {
            __raw = ''
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
                    -- Close the tree if file was opened
                    api.tree.close()
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
              min = 30;
              max = -1;
              padding = 1;
            };
          };
          git = {
            enable = true;
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
