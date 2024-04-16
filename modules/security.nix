{user, ...}: {
  security = {
    rtkit = {
      enable = true;
    };
    polkit = {
      enable = true;
      extraConfig =
        /*
        javascript
        */
        ''
          polkit.addRule(function(action, subject) {
            const isInit = action.id == "org.corectrl.helper.init" || action.id == "org.corectrl.helperkiller.init";
            const isLocal = subject.local == true;
            const isActive = subject.active == true; 
            const hasUserGroup = subject.isInGroup("${user}");
            if (isInit && isLocal && isActive && hasUserGroup) {
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
