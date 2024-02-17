{pkgs,...}: {
  programs = {
    nixvim = {
      extraPackages = with pkgs; [gnutar curl gcc_multi];
      plugins = {
        treesitter = {
          enable = true;
        };
      };
    };
  };
}
