{...}: {
  programs = {
    nixvim = {
      plugins = {
        hardtime = {
          enable = false;
          restrictedKeys = {
            "h" = ["n" "x"];
            "j" = ["n" "x"];
            "k" = ["n" "x"];
            "l" = ["n" "x"];
            "-" = ["n" "x"];
            "+" = ["n" "x"];
            "gj" = ["n" "x"];
            "gk" = ["n" "x"];
            "<CR>" = ["n" "x"];
            "<C-M>" = ["n" "x"];
            "<C-N>" = ["n" "x"];
            "<C-P>" = ["n" "x"];
          };
        };
      };
    };
  };
}
