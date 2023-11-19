{ config, ... }: {
  networking = {
    hostName = "nixos";
    firewall = {
      enable = true;
    };
    networkmanager = {
      enable = true;
      unmanaged = [
        "*" 
        "except:type:wwan" 
        "except:type:wifi"
        "except:type:ethernet"
      ];
    };
    wireless = {
      enable = true;
      userControlled = {
        enable = true;
      };
      environmentFile = config.sops.secrets.wifi.path;
      networks = {
        "@home_uuid@" = {
          priority = 1;
          pskRaw = "@home_psk@";
        };
        "@alt_home_uuid@" = {
          priority = 2;
          pskRaw = "@alt_home_psk@";
        };
        eduroam = {
          priority = 3;
          auth = ''
            key_mgmt=WPA-EAP
            pairwise=CCMP
            group=CCMP TKIP
            eap=TTLS
            ca_cert="/etc/ssl/certs/ca.pem"
            altsubject_match="DNS:wlan.thm.de"
            phase2="auth=MSCHAPV2"
            anonymous_identity="anonymous@thm.de"
            identity="@uni_identity@"
            password="@uni_password@"
          '';
        };
      };
    };
  };
}
