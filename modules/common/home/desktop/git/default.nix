{ pkgs, config, editor, ... }: {
  home = {
    packages = with pkgs; [
      gitflow
    ];
  };
  programs = {
    git = {
      enable = true;
      userName = "Clemens Horn";
      userEmail = "clemens.horn@mni.thm.de";
      package = pkgs.gitFull;
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
          editor = editor;
        };
      };
    };
  };
}
