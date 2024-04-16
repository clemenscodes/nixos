{...}: {
  programs = {
    nixvim = {
      filetype = {
        pattern = {
          ".*/hyprland%.conf" = "hyprlang";
        };
      };
    };
  };
}
