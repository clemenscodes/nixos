{lib, ...}: {
  imports = [
    ./postgres
  ];
  options = {
    modules = {
      databases = {
        enable = lib.mkEnableOption "Enable databases" // {default = false;};
      };
    };
  };
}
