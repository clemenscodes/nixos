{...}: {
  imports = [./modules];
  programs = {
    nixvim = {
      plugins = {
        mini = {
          enable = true;
        };
      };
    };
  };
}
