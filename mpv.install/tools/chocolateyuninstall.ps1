$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
Start-ChocolateyProcessAsAdmin "/K $toolsDir\mpv-uninstall.bat /u" 'cmd.exe' -validExitCodes '0'
