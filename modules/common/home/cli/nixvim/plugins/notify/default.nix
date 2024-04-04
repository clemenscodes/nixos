{...}: {
  programs = {
    nixvim = {
      plugins = {
        notify = {
          enable = true;
          topDown = false;
          timeout = 3000;
          maxWidth = 200;
          render = "minimal";
        };
      };
    };
  };
}
