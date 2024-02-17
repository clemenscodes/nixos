{...}: {
  programs = {
    nixvim = {
      plugins = {
        project-nvim = {
          enable = true;
          patterns = [
            ".git" 
            "nx.json"
            "package.json"
            "Cargo.toml"
            "Makefile" 
            "CMakeLists.txt" 
          ];
        };
      };
    };
  };
}
