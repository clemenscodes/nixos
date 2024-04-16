{
  editor,
  browser,
  ...
}: {
  programs = {
    gh = {
      enable = true;
      settings = {
        version = 1;
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
