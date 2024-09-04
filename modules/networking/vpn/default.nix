{lib, ...}:
with lib; {
  imports = [
    ./thm
  ];
  options = {
    modules = {
      networking = {
        vpn = {
          enable = mkEnableOption "Enable vpn" // {default = false;};
        };
      };
    };
  };
}
