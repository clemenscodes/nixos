{ pkgs, ... }: {
  services = {
   # xserver = {
   #   enable = true;
   #   dpi = 96;
   #   layout = "de"; 
   #   videoDrivers = [ "nvidia" ];
   #   xkbOptions = "caps:swapescape";
   #   deviceSection = ''
   #    VendorName "NVIDIA Corporation"
   #    Option "TearFree" "true"
   #   '';
   #   screenSection = ''
   #     Option "metamodes" "DP-0: 1920x1080_240+1920+0, HDMI-0: 1920x1080+0+0 { ForceFullCompositionPipeline = On }"
   #     Option "AllowIndirectGLXProtocol" "off"
   #     Option "TripleBuffer" "on"
   #   '';
   #   exportConfiguration = true;
   #   desktopManager = {
   #     xterm = {
   #       enable = false;
   #     };
   #   };
   #   xrandrHeads = [ 
   #     { output = "DP-0"; primary = true; }
   #     { output = "HDMI-0"; }
   #   ];
   #   displayManager = {
   #     defaultSession = "none+xmonad";
   #     sessionCommands = ''
   #       xmodmap -e "clear mod4"
   #       xmodmap -e "add mod4 = 0xff1b"
   #       xset -dpms # Disable Energy Star, as we are going to suspend anyway and it may hide "success" on that
   #       xset s blank # `noblank` may be useful for debugging
   #       xset s 300
   #       ${pkgs.lightlocker}/bin/light-locker --idle-hint &
   #     '';
   #   };
   #   windowManager = {
   #     xmonad = {
   #       enable = true;
   #       enableContribAndExtras = true;
   #       extraPackages = haskellPackages: [
   #         haskellPackages.xmonad
   #         haskellPackages.xmonad-contrib
   #         haskellPackages.xmonad-extras
   #         haskellPackages.xmobar
   #       ];
   #       config = builtins.readFile xmonad/xmonad.hs;
   #     };
   #   };
   # };
   # logind = {
   #   extraConfig = ''
   #     IdleAction=hybrid-sleep
   #     IdleActionSec=20s
   #   '';
   # };
  };
  systemd = {
    targets = {
      hybrid-sleep = {
        enable = true;
      };
    };
  };
}
