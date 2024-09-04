{lib, ...}:
with lib; {
  imports = [
    ./pycharm
    ./clion
  ];
  options = {
    modules = {
      editor = {
        jetbrains = {
          enable = mkEnableOption "Enables JetBrains products" // {default = false;};
        };
      };
    };
  };
}
