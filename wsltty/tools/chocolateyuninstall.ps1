$packageName = 'wsltty'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Uninstall-BinFile -Name 'wsl'
Uninstall-BinFile -Name 'wsl~'
Uninstall-BinFile -Name 'wsl-l'
