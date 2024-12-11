{lib, ...}: {
  imports = [
    ./rclone
  ];
  options = {
    modules = {
      storage = {
        enable = lib.mkEnableOption "Enable storage" // {default = false;};
      };
    };
  };
}
