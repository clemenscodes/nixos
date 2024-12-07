{pkgs}:
pkgs.writeShellScriptBin "logoutlaunch" ''
  dir="$HOME/.config/rofi/powermenu"
  theme='style'
  lastlogin="`${pkgs.util-linux}/bin/last $USER | head -n1 | tr -s ' ' | cut -d' ' -f5,6,7`"
  uptime="`${pkgs.procps}/bin/uptime -p | sed -e 's/up //g'`"
  host=`${pkgs.hostname}/bin/hostname`
  shutdown="shutdown";
  reboot="reboot";
  hibernate="hibernate";
  logout="logout";
  lock="lock";
  suspend='suspend'
  yes='✓'
  no='✗'

  rofi_cmd() {
    ${pkgs.rofi-wayland}/bin/rofi -dmenu \
      -p "  $USER@$host" \
      -mesg "  Uptime: $uptime" \
      -theme ''${dir}/''${theme}.rasi
  }

  confirm_cmd() {
    ${pkgs.rofi-wayland}/bin/rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 350px;}' \
      -theme-str 'mainbox {orientation: vertical; children: [ "message", "listview" ];}' \
      -theme-str 'listview {columns: 2; lines: 1;}' \
      -theme-str 'element-text {horizontal-align: 0.5;}' \
      -theme-str 'textbox {horizontal-align: 0.5;}' \
      -dmenu \
      -p 'Confirmation' \
      -mesg 'Are you sure?' \
      -theme ''${dir}/''${theme}.rasi
  }

  confirm_exit() {
    echo -e "$yes\n$no" | confirm_cmd
  }

  run_rofi() {
    echo -e "$lock\n$suspend\n$logout\n$hibernate\n$reboot\n$shutdown" | rofi_cmd
  }

  run_cmd() {
    selected="$(confirm_exit)"
    if [[ "$selected" != "$yes" ]]; then
      exit 0
    fi
    if [[ $1 == '--shutdown' ]]; then
     shutdown -h now
    elif [[ $1 == '--reboot' ]]; then
      ${pkgs.systemd}/bin/systemctl reboot
    elif [[ $1 == '--hibernate' ]]; then
      lockout
      sleep 1
      ${pkgs.systemd}/bin/systemctl hibernate
    elif [[ $1 == '--suspend' ]]; then
      ${pkgs.mpc-cli}/bin/mpc -q pause
      ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      lockout
      sleep 1
      ${pkgs.systemd}/bin/systemctl suspend
    elif [[ $1 == '--logout' ]]; then
      signout
    fi
  }

  chosen="$(run_rofi)"

  case ''${chosen} in
    $shutdown) run_cmd --shutdown ;;
    $reboot) run_cmd --reboot ;;
    $hibernate) run_cmd --hibernate ;;
    $lock) loginctl lock-session ;;
    $suspend) run_cmd --suspend ;;
    $logout) run_cmd --logout ;;
  esac
''
