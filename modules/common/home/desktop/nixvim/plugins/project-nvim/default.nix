{...}: {
  programs = {
    nixvim = {
      plugins = {
        project-nvim = {
          enable = true;
          patterns = [
            ".git"
            "nx.json"
          ];
        };
      };
    };
  };
}
