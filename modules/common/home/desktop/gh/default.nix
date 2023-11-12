{ ... }: {
  programs = {
    gh = {
      enable = true;
      settings = {
        editor = "nvim";
        git_protocol = "ssh";
        browser = "brave";
      };
      gitCredentialHelper = {
        enable = true;
      };
    };
  };
}
