{user, config, ...}: {
  wsl = {
    enable = true;
    defaultUser = user;
    interop = {
      includePath = true;
      register = true;
    };
    nativeSystemd = true;
    startMenuLaunchers = true;
    usbip = {
      enable = true;
      autoAttach = [];
    };
    useWindowsDriver = true;
    wslConf = {
      automount = {
        enabled = true;
        mountFsTab = false;
        options = "metadata,uid=1000,gid=100";
        root = "/mnt";
      };
      interop = {
        enabled = true;
        appendWindowsPath = false;
      };
      network = {
        generateHosts = true;
        generateResolvConf = true;
        hostname = config.networking.hostName;
      };
      user = {
        default = user;
      };
    };
  };
}
