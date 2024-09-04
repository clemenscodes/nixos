{lib, ...}:
with lib; {
  imports = [
    ./vps
  ];
  options = {
    modules = {
      operations = {
        enable = mkEnableOption "Enable operations" // {default = false;};
      };
    };
  };
}
