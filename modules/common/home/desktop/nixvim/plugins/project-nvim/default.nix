{...}: {
  programs = {
    nixvim = {
      plugins = {
        project-nvim = {
          enable = true;
          ignoreLsp = ["rust-analyzer"];
          detectionMethods = ["pattern"];
          patterns = [
            ".git"
            "nx.json"
          ];
        };
      };
    };
  };
}
