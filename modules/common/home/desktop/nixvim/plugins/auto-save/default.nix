{...}: {
  programs = {
    nixvim = {
      plugins = {
        auto-save = {
          enable = true;
          writeAllBuffers = true;
          triggerEvents = ["TextChanged"];
          extraOptions = {};
        };
      };
    };
  };
}
