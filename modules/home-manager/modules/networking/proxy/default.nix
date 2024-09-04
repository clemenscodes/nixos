{lib, ...}:
with lib; {
  imports = [
    ./charles
    ./mitmproxy
  ];
  options = {
    modules = {
      networking = {
        proxy = {
          enable = mkEnableOption "Enable proxy tools" // {default = false;};
        };
      };
    };
  };
}
