{lib, ...}:
with lib; {
  imports = [
    ./tmux
    ./zellij
  ];
  options = {
    modules = {
      shell = {
        multiplexers = {
          enable = mkEnableOption "Enable terminal multiplexers" // {default = false;};
        };
      };
    };
  };
}
