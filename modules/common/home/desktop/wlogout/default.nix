{ pkgs, ... }: {
  programs = {
    wlogout = {
      enable = true;
      layout = [
        {
          label = "lock";
          action = "pkill wlogout && sleep 1 && ${pkgs.swaylock-effects}/bin/swaylock -f";
          text = "Lock";
          keybind = "l";
        }
        {
          label = "logout";
          action = "${pkgs.hyprland}/bin/hyprctl dispatch exit";
          text = "Logout";
          keybind = "e";
        }
        {
          label = "shutdown";
          action = "${pkgs.systemd}/bin/shutdown now";
          text = "Shutdown";
          keybind = "s";
        }
        {
          label = "reboot";
          action = "${pkgs.systemd}/bin/reboot";
          text = "Reboot";
          keybind = "r";
        }
        {
            label = "suspend";
            action = "${pkgs.systemd}/bin/systemctl suspend";
            text = "Suspend";
            keybind = "u";
        }
        {
            label = "hibernate";
            action = "${pkgs.systemd}/bin/systemctl hibernate";
            text = "Hibernate";
            keybind = "h";
        }
      ];
      style = ''
        * {
          background-image: none;
          font-family: "Iosevka Nerd Font", sans-serif;
        }

        window {
          background-color: rgba(12, 12, 12, 0.9);
        }

        button {
          color: #FFFFFF;
          background-color: #1E1E1E;
          border-style: solid;
          border-width: 2px;
          background-repeat: no-repeat;
          background-position: center;
          background-size: 25%;
        }
        
        button:focus, button:active, button:hover {
          background-color: rgba(202, 1, 35, 0.2);
          outline-style: none;
        }
        
        #lock,
        #logout,
        #suspend,
        #hibernate,
        #shutdown, 
        #reboot {
          margin: 12px;
          border-radius: 20px;
          color: white;
        }

        #lock {
          background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/lock.png"), url("/usr/local/share/wlogout/icons/lock.png"));
        }
        
        #logout {
          background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/logout.png"), url("/usr/local/share/wlogout/icons/logout.png"));
        }
        
        #suspend {
          background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/suspend.png"), url("/usr/local/share/wlogout/icons/suspend.png"));
        }
        
        #hibernate {
          background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/hibernate.png"), url("/usr/local/share/wlogout/icons/hibernate.png"));
        }
        
        #shutdown {
          background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/shutdown.png"), url("/usr/local/share/wlogout/icons/shutdown.png"));
        }
        
        #reboot {
          background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/reboot.png"), url("/usr/local/share/wlogout/icons/reboot.png"));
        }
      '';
    };
  };
}
