{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.development;
in {
  options = {
    modules = {
      development = {
        git = {
          enable = lib.mkEnableOption "Enable Git" // {default = cfg.enable;};
          userName = lib.mkOption {
            type = lib.types.str;
            default = null;
          };
          userEmail = lib.mkOption {
            type = lib.types.str;
            default = null;
          };
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && cfg.git.enable) {
    home = {
      packages = with pkgs; [
        gitflow
      ];
    };
    programs = {
      lazygit = {
        inherit (cfg.git) enable;
      };
      gitui = {
        inherit (cfg.git) enable;
      };
      git = {
        inherit (cfg.git) enable userName userEmail;
        package = pkgs.gitFull;
        attributes = [
          "*.pdf diff=pdf"
        ];
        difftastic = {
          inherit (cfg.git) enable;
          display = "inline";
          background = "dark";
          color = "always";
        };
        extraConfig = {
          core = {
            whitespace = "trailing-space,space-before-tab";
            autocrlf = "input";
            editor = config.modules.editor.defaultEditor;
          };
          credential = {
            helper = "libsecret";
          };
          user = {
            signingkey = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
          };
          gpg = {
            program = "gpg2";
            format = "ssh";
          };
          init = {
            defaultBranch = "main";
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
