{pkgs, ...}: let
  ng = pkgs.vimUtils.buildVimPlugin {
    name = "nx";
    src = pkgs.fetchFromGitHub {
      owner = "joeveiga";
      repo = "ng.nvim";
      rev = "d02deda535e1b05014ce4f36781d2f45c174065a";
      hash = "sha256-9Koecth1grLq01OCFYkB/qMl2xlAst5No5ZPRBnuLU8=";
    };
  };
in {
  programs = {
    nixvim = {
      extraPlugins = [ng];
      plugins = {
        lsp = {
          postConfig =
            /*
            lua
            */
            ''
              local lsp = require('lspconfig')
              local util = lsp.util
              lsp["angularls"].setup({
                cmd = { "ngserver", "--stdio", "--tsProbeLocations", "", "--ngProbeLocations", "" }
                file_types = { "typescript", "html", "typescriptreact", "typescript.tsx" },
                root_dir = util.root_pattern(".git"),
                on_new_config = function(new_config, new_root_dir)
                  new_config.cmd = cmd
                end
              })
            '';
        };
        which-key = {
          registrations = {
            "<leader>wgt" = "Web go to template (Angular)";
            "<leader>wgc" = "Web go to component (Angular)";
          };
        };
      };
      keymaps = [
        {
          action =
            /*
            lua
            */
            ''
              function()
                require('ng').goto_template_for_component
              end
            '';
          key = "<leader>wgt";
          mode = "n";
          lua = true;
          options = {
            silent = true;
            desc = "Web go to template (Angular)";
          };
        }
        {
          action =
            /*
            lua
            */
            ''
              function()
                require('ng').goto_component_with_template_file
              end
            '';
          key = "<leader>wgc";
          mode = "n";
          lua = true;
          options = {
            silent = true;
            desc = "Web go to component (Angular)";
          };
        }
      ];
    };
  };
}
