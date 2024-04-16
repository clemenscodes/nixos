{...}: {
  programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true;
      config = {
        global = {
          warn_timeout = "100h";
        };
      };
      nix-direnv = {
        enable = true;
      };
    };
  };
}
