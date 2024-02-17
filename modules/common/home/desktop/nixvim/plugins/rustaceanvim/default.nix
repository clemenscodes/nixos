{pkgs, ...}: {
  programs = {
    nixvim = {
      extraPackages = with pkgs; [cargo rustc];
      plugins = {
        rustaceanvim = {
          enable = true;
          tools = {
            executor = "toggleterm";
          };
          extraOptions = {};
        };
      };
    };
  };
}
