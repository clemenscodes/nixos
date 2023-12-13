{...}: {
  xdg = {
    desktopEntries = {
      discord = {
        name = "Discord";
        type = "Application";
        categories = ["Network" "InstantMessaging"];
        exec = "discord --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-features=WebRTCPipeWireCapturer";
        genericName = "All-in-one cross-platform voice and text chat for gamers";
        icon = "discord";
        mimeType = ["x-scheme-handler/discord"];
      };
    };
  };
}
