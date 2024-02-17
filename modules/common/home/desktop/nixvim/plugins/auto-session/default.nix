{...}: {
  programs = {
    nixvim = {
      options = {
        sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions";
      };
      plugins = {
        auto-session = {
          enable = true;
          autoSave = {
            enabled = true;
          };
          autoRestore = {
            enabled = true;
          };
          autoSession = {
            enabled = true;
            createEnabled = true;
            enableLastSession = true;
          };
          extraOptions = {};
        };
      };
    };
  };
}
