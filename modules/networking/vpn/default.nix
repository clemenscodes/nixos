{lib, ...}: {
  imports = [
    ./thm
  ];
  options = {
    modules = {
      networking = {
        vpn = {
          enable = lib.mkEnableOption "Enable vpn" // {default = false;};
        };
      };
    };
  };
}
