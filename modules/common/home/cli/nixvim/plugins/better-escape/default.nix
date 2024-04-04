{...}: {
  programs = {
    nixvim = {
      plugins = {
        better-escape = {
          enable = true;
          mapping = ["jj" "jk"];
        };
      };
    };
  };
}
