{...}: {
  programs = {
    nixvim = {
      plugins = {
        project-nvim = {
          enable = true;
          ignoreLsp = ["rust-analyzer"];
          detectionMethods = ["pattern"];
          enableTelescope = true;
          patterns = [
            ".git"
            "nx.json"
          ];
        };
      };
    };
  };
}
