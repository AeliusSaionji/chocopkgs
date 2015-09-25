$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
Start-Process cmd.exe -ArgumentList "/C $toolsDir\mpv-uninstall.bat" -Verb Runas
