{...}: {
  programs = {
    nixvim = {
      plugins = {
        alpha = {
          enable = true;
          iconsEnabled = true;
          opts = {};
          layout = [
            {
              type = "padding";
              val = 2;
            }
            {
              type = "text";
              val = [
                "███╗   ██╗██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗"
                "████╗  ██║██║╚██╗██╔╝██║   ██║██║████╗ ████║"
                "██╔██╗ ██║██║ ╚███╔╝ ██║   ██║██║██╔████╔██║"
                "██║╚██╗██║██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║"
                "██║ ╚████║██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║"
                "╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝"
              ];
              opts = {
                position = "center";
                hl = "Type";
              };
            }
            {
              type = "padding";
              val = 2;
            }
            {
              type = "group";
              opts = {
                position = "center";
              };
              val = [
                {
                  type = "button";
                  val = "  Find Projects";
                  on_press.__raw =
                    /*
                    lua
                    */
                    ''
                      function()
                        vim.cmd[[
                          Telescope projects
                        ]]
                      end
                    '';
                  opts = {
                    hl = "hl_group";
                    position = "center";
                    align_shortcut = "right";
                    hl_shortcut = "hl_group";
                    cursor = 0;
                    width = 50;
                    shrink_margin = true;
                    shortcut = "<leader>fp";
                  };
                }
              ];
            }
            {
              type = "padding";
              val = 2;
            }
            {
              type = "text";
              val = "Why use C?";
              opts = {
                position = "center";
                hl = "Keyword";
              };
            }
          ];
        };
      };
    };
  };
}
