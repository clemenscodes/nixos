{user, ...}: {
  security = {
    rtkit = {
      enable = true;
    };
    polkit = {
      enable = true;
      extraConfig = ''
        polkit.addRule(function(action, subject) {
            if ((action.id == "org.corectrl.helper.init" ||
                 action.id == "org.corectrl.helperkiller.init") &&
                subject.local == true &&
                subject.active == true &&
                subject.isInGroup("${user}")) {
                    return polkit.Result.YES;
            }
        });
      '';
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
