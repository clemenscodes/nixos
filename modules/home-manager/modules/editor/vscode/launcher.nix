{...}: {
  xdg = {
    desktopEntries = {
      codium = {
        name = "VSCodium";
        type = "Application";
        categories = ["Utility" "TextEditor" "Development" "IDE"];
        comment = "Code Editing. Redefined.";
        exec = ''sh -c "LD_LIBRARY_PATH=\\$NIX_LD_LIBRARY_PATH codium --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-features=WaylandWindowDecorations"'';
        genericName = "Text Editor";
        icon = "vscodium";
        mimeType = ["x-scheme-handler/vscode"];
        noDisplay = false;
        startupNotify = true;
        terminal = false;
      };
    };
  };
}
