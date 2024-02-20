{pkgs, ...}: {
  programs = {
    nixvim = {
      extraConfigLuaPost = /* lua */
            ''
              require('neotest').setup {
                adapters = {
                  require('rustaceanvim.neotest')
                },
              }
            '';
      extraPlugins = with pkgs; [
	vimPlugins.neotest
      ];
    };
  };
}
