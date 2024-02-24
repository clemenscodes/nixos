{
  pkgs,
  config,
  machine,
  user,
  ...
}: {
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting = {
        enable = true;
      };
      enableAutosuggestions = true;
      autocd = true;
      completionInit = true;
      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "git-flow"
          "systemd"
          "colored-man-pages"
          "colorize"
        ];
      };
      dotDir = ".config/zsh";
      shellAliases = with pkgs; {
        update = "cd $XDG_CONFIG_HOME/nixos && git pull";
        sw = "update && sudo nixos-rebuild switch --flake ./#${machine}";
        src = "omz reload";
        ls = "${eza}/bin/eza";
        grep = "${ripgrep}/bin/rg";
        nd = "nix develop -c $SHELL";
        ne = "cd $NIX_CONFIG_HOME && lfcd";
        ssh = "kitten ssh";
        nedesk = "cd $NIX_CONFIG_HOME/modules/common/home/desktop && lfcd";
        nenvim = "cd $NIX_CONFIG_HOME/modules/common/home/desktop/nixvim && lfcd";
        v = "nvim .";
        V = "cd $XDG_VIDEOS_DIR";
        D = "cd $XDG_DOWNLOAD_DIR";
        M = "cd $XDG_MUSIC_DIR";
        I = "cd $XDG_PICTURES_DIR";
        S = "cd $XDG_PICTURES_DIR/screenshots";
        docs = "cd $XDG_DOCUMENTS_DIR";
        isos = "cd $XDG_DATA_HOME/isos";
        notes = "cd $XDG_DATA_HOME/notes";
        rr = "cd $HOME/.local/src";
      };
      history = {
        path = "${config.xdg.dataHome}/zsh/zsh_history";
      };
      historySubstringSearch = {
        enable = true;
      };
      initExtraBeforeCompInit = ''
        autoload -U colors && colors
      '';
      initExtra = ''
        zstyle ':completion*' menu select
        bindkey -v
        bindkey -M menuselect 'h' vi-backward-char
        bindkey -M menuselect 'k' vi-up-line-or-history
        bindkey -M menuselect 'l' vi-forward-char
        bindkey -M menuselect 'j' vi-down-line-or-history
        bindkey -v '^?' backward-delete-char
        function zle-keymap-select () {
            case $KEYMAP in
                vicmd) echo -ne '\e[1 q';;
                viins|main) echo -ne '\e[5 q';;
            esac
        }
        zle -N zle-keymap-select
        zle-line-init() {
            zle -K viins
            echo -ne "\e[5 q"
        }
        zle -N zle-line-init
        echo -ne '\e[5 q'
        preexec() { echo -ne '\e[5 q' ;}
        lfcd () {
            tmp="$(mktemp -uq)"
            trap 'rm -f $tmp >/dev/null 2>&1' HUP INT QUIT TERM PWR EXIT
            lf -last-dir-path="$tmp" "$@"
            if [ -f "$tmp" ]; then
                dir="$(cat "$tmp")"
                [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
            fi
        }
        vhere () {
            tmp="$(mktemp -uq)"
            trap 'rm -f $tmp >/dev/null 2>&1' HUP INT QUIT TERM PWR EXIT
            nvim .
            if [ -f "$tmp" ]; then
                dir="$(cat "$tmp")"
                [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
            fi
        }
        bindkey -s '^o' 'lfcd\n'
        bindkey -s '^v' 'vhere\n'
        autoload edit-command-line; zle -N edit-command-line
        bindkey '^e' edit-command-line
        bindkey -M vicmd '^[[P' vi-delete-char
        bindkey -M vicmd '^e' edit-command-line
        bindkey -M visual '^[[P' vi-delete
        if [[ -o interactive ]]; then
          export GH_TOKEN=$(${pkgs.bat}/bin/bat ${config.sops.secrets.github_token.path} --style=plain)
        fi
        eval "$(direnv hook zsh)"
      '';
      profileExtra = ''
        export NIXOS_OZONE_WL=1
        export NIX_CONFIG_HOME=$XDG_CONFIG_HOME/nixos
        export CARGO_HOME="$XDG_DATA_HOME/cargo"
        export JAVA_HOME="/etc/profiles/per-user/${user}"
        export GOPATH="$XDG_DATA_HOME/go"
        export MBSYNCRC="$XDG_CONFIG_HOME/mbsync/config"
        export M2_HOME="$XDG_DATA_HOME/m2"
        export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv";
        export WINEPREFIX="$XDG_DATA_HOME/wine";
        export LD_LIBRARY_PATH="/run/opengl-driver/lib:/run/opengl-driver-32/lib:$LD_LIBRARY_PATH";
        export LESS=-R
        export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"
        export LESS_TERMCAP_md="$(printf '%b' '[1;36m')"
        export LESS_TERMCAP_me="$(printf '%b' '[0m')"
        export LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')"
        export LESS_TERMCAP_se="$(printf '%b' '[0m')"
        export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"
        export LESS_TERMCAP_ue="$(printf '%b' '[0m')"
      '';
    };
  };
}
