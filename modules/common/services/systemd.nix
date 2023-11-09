{ user, ... }: {
    systemd = {
        services = {
            mpd = {
                environment = {
                    XDG_RUNTIME_DIR = "/run/user/1000";
                };
            };
        };
    };
}
