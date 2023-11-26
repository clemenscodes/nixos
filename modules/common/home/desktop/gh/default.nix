{
  editor,
  browser,
  ...
}: {
  programs = {
    gh = {
      enable = true;
      settings = {
        editor = editor;
        git_protocol = "ssh";
        browser = browser;
      };
      gitCredentialHelper = {
        enable = true;
      };
    };
  };
}
