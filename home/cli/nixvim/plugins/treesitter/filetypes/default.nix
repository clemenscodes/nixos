{...}: {
  programs = {
    nixvim = {
      filetype = {
        pattern = {
          ".*/hyprland%.conf" = "hyprlang";
          ".*%.component%.html" = "angular.html";
          ".prototools" = "toml";
        };
      };
    };
  };
}
