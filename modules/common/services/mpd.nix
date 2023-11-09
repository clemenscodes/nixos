{ user, ... }: {
    services = {
        mpd = {
            enable = true;
            user = "${user}";
            extraConfig = ''
                audio_output {
                    type "pipewire"
                    name "PipeWire"
                }
            '';
        };
    };
}
