{...}: {
  programs = {
    nixvim = {
      extraConfigLuaPre = ''
        local api = require("nvim-tree.api")
        
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
      '';
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
        {
          action = "function() edit_or_open() end";
          lua = true;
          key = "l";
          mode = "n";
          options = {
            silent = true;
            desc = "Edit or open";
          };
        }
        {
          action = "function() vsplit_preview() end";
          lua = true;
          key = "L";
          mode = "n";
          options = {
            silent = true;
            desc = "VSplit preview";
          };
        }
        {
          action = "function() api.tree.close() end";
          lua = true;
          key = "h";
          mode = "n";
          options = {
            silent = true;
            desc = "Close";
          };
        }
        {
          action = "function() api.tree.collape_all() end";
          lua = true;
          key = "H";
          mode = "n";
          options = {
            silent = true;
            desc = "Collapse all";
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
