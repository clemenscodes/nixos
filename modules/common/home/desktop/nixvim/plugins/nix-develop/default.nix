{...}: {
  programs = {
    nixvim = {
      autoCmd = [
        {
          event = ["DirChanged"];
          callback.__raw =
            /*
            lua
            */
            ''
              function()
                local flake_found = false;
                local direnv_found = false;
                local cwd = vim.fn.getcwd();
                local files = vim.split(vim.fn.glob(cwd .. "/*") .. '\n' .. vim.fn.glob(cwd .. "/.[^.]*",1), '\n')
                local flake = cwd .. "/" .. "flake.nix"
                local direnv = cwd .. "/" .. ".envrc"
                for _, file in pairs(files) do
                    if file == flake then
                        flake_found = true;
                    end
                    if file == direnv then
                        direnv_found = true;
                    end
                end
                if flake_found and direnv_found then
                  require("nix-develop").nix_develop({})
                end
              end
            '';
        }
      ];
      plugins = {
        nix-develop = {
          enable = true;
        };
      };
    };
  };
}
