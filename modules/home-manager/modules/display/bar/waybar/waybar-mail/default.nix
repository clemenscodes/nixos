{pkgs}:
pkgs.writeShellScriptBin "waybar-mail" ''

  mail=$(echo)
  tooltip=$(echo)
  class=$(echo "mail")

  unread=$(${pkgs.findutils}/bin/find $XDG_DATA_HOME/mail/*/[Ii][Nn][Bb][Oo][Xx]/new/* -type f 2>/dev/null | ${pkgs.coreutils}/bin/wc -l)
  [ "$unread" = "0" ] && [ "$icon" = "" ] || mail="$unread 📬"

  echo $mail
  echo $tooltip
  echo $class
''
