{...}: {
  programs = {
    nixvim = {
      plugins = {
        startup = {
          enable = true;
          theme = "dashboard";
        };
      };
    };
  };
}
