{
  pkgs,
  osConfig,
}: let
  corectrlHandle =
    if osConfig.modules.gpu.amd.corectrl.enable
    then "sudo pkill corectrl"
    else "";
in
  pkgs.writeShellScriptBin "signout" ''
    "${corectrlHandle}"
    ${pkgs.systemd}/bin/loginctl kill-user $USER
  ''
