{...}: {
  programs = {
    nixvim = {
      plugins = {
        auto-save = {
          enable = true;
          triggerEvents = ["TextChanged"];
          extraOptions = {};
        };
      };
    };
  };
}
