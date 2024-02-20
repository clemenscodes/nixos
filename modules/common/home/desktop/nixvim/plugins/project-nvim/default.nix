{...}: {
  programs = {
    nixvim = {
      plugins = {
        project-nvim = {
          enable = true;
          ignoreLsp = ["rust-analyzer"];
          patterns = [
            ".git"
            "nx.json"
          ];
        };
      };
    };
  };
}
