{lib, ...}:
with lib; {
  imports = [
    ./pycharm
    ./clion
  ];
  options = {
    jetbrains = {
      enable = mkEnableOption "Enables jetbrain products";
    };
  };
}
