{...}: {
  programs = {
    nixvim = {
      options = {
        shiftwidth = 2;
        tabstop = 2;
        scrolloff = 8;
        expandtab = true;
      };
    };
  };
}
