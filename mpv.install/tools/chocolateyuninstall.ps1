$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
Remove-Item -Path "$ENV:ChocolateyInstall\bin\mpv.exe"
Remove-Item -Path "$ENV:ChocolateyInstall\bin\mpv.com"
Start-ChocolateyProcessAsAdmin "/K $toolsDir\mpv-uninstall.bat silent" 'cmd.exe' -validExitCodes '0'
