{user, ...}: {
  security = {
    rtkit = {
      enable = true;
    };
    polkit = {
      enable = true;
    };
    pam = {
      services = {
        swaylock = {};
        "${user}" = {
          gnupg = {
            enable = true;
          };
        };
      };
    };
    sudo = {
      extraRules = [
        {
          users = ["${user}"];
          commands = [
            {
              command = "ALL";
              options = ["NOPASSWD" "SETENV"];
            }
          ];
        }
      ];
    };
  };
}
