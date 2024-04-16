{pkgs}:
pkgs.writeShellScriptBin "waybar-mail" ''

  mail=$(echo)
  tooltip=$(echo)
  class=$(echo "mail")

  unread=$(${pkgs.findutils}/bin/find $XDG_DATA_HOME/mail/*/[Ii][Nn][Bb][Oo][Xx]/new/* -type f | ${pkgs.coreutils}/bin/wc -l 2>/dev/null)
  [ "$unread" = "0" ] && [ "$icon" = "" ] || mail="$unread 📬"

  echo $mail
  echo $tooltip
  echo $class
''
