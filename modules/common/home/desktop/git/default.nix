{ editor, ... }: {
  programs = {
    git = {
      enable = true;
      userName = "Clemens Horn";
      userEmail = "clemens.horn@mni.thm.de";
      extraConfig = {
        init = {
          defaultBranch = "main";
        };
        pull = {
          rebase = false;
        };
        push = {
          autoSetupRemote = true;
        };
        core = {
          whitespace = "trailing-space,space-before-tab";
          editor = editor;
        };
      };
    };
  };
}
