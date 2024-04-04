{pkgs, ...}:
with pkgs; {
  home = {
    packages = [davinci-resolve];
  };
  xdg = {
    desktopEntries = {
      resolve = {
        name = "Davinci Resolve";
        genericName = "Video Editor";
        exec = "env QT_QPA_PLATFORM=xcb ${davinci-resolve}/bin/davinci-resolve %u";
        icon = "DV_Resolve";
        terminal = false;
        type = "Application";
        categories = ["AudioVideoEditing"];
        mimeType = ["application/x-resolveproj"];
      };
    };
  };
}
