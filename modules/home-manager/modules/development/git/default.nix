{
  pkgs,
  config,
  osConfig,
  lib,
  ...
}: let
  cfg = config.modules.development;
in
  with lib; {
    options = {
      modules = {
        development = {
          git = {
            enable = mkEnableOption "Enable Git" // {default = cfg.enable;};
          };
        };
      };
    };
    config = mkIf (cfg.enable && cfg.git.enable) {
      home = {
        packages = with pkgs; [
          gitflow
        ];
      };
      programs = {
        lazygit = {
          enable = cfg.git.enable;
        };
        git = {
          enable = cfg.git.enable;
          userName = "Clemens Horn";
          userEmail = "clemens.horn@mni.thm.de";
          package = pkgs.gitFull;
          delta = {
            enable = true;
            catppuccin = mkIf (osConfig.modules.themes.catppuccin.enable) {
              inherit (osConfig.modules.themes.catppuccin) enable flavor;
            };
          };
          extraConfig = {
            user = {
              signingkey = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
            };
            init = {
              defaultBranch = "main";
            };
            gpg = {
              program = "gpg2";
              format = "ssh";
            };
            commit = {
              gpgsign = true;
            };
            pull = {
              rebase = false;
            };
            push = {
              autoSetupRemote = true;
              default = "current";
            };
            credential = {
              helper = "libsecret";
            };
            core = {
              whitespace = "trailing-space,space-before-tab";
              autocrlf = "input";
              editor = config.modules.editor.defaultEditor;
            };
            diff = {
              tool = "nvimdiff";
              guitool = "nvimdiff";
            };
            difftool = {
              prompt = false;
              guiDefault = false;
            };
            merge = {
              tool = "nvimdiff";
              guitool = "nvimdiff";
            };
            mergetool = {
              prompt = false;
              guiDefault = false;
              keepBackup = false;
            };
            "mergetool \"vimdiff\"" = {
              layout = "(LOCAL,BASE,REMOTE) / MERGED + (LOCAL,MERGED,REMOTE) + LOCAL,REMOTE + (LOCAL,MERGED) / (REMOTE,MERGED) + (BASE,LOCAL) / (BASE,REMOTE)";
            };
          };
        };
      };
    };
  }
