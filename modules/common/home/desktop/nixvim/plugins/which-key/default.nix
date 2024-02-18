{...}: {
  programs = {
    nixvim = {
      options = {
        timeout = true;
        timeoutlen = 300;
      };
      plugins = {
        which-key = {
          enable = true;
          ignoreMissing = true;
          registrations = {
            "<Tab>" = "Next buffer";
            "<S-Tab>" = "Previous buffer";
          };
        };
      };
    };
  };
}
