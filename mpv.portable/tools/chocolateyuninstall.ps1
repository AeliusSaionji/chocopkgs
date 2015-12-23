$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
Remove-Item -Path "$ENV:ChocolateyInstall\bin\mpv.exe"
Remove-Item -Path "$ENV:ChocolateyInstall\bin\mpv.com"
