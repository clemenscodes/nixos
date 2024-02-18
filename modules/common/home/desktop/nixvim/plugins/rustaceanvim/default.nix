{pkgs, ...}: {
  programs = {
    nixvim = {
      extraPackages = with pkgs; [cargo];
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
