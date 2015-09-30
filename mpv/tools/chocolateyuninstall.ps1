$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
Remove-Item -Path "$ENV:ChocolateyInstall\bin\mpv.exe"
Remove-Item -Path "$ENV:ChocolateyInstall\bin\mpv.com"
# TODO Change this test to directly probe the registry
If (Test-Path -Path "$ENV:Temp\chocolatey\mpv\mpv-install-master\mpv-uninstall.bat") {
	$proceedRemove = Read-Host 'Do you wish to unrergister mpv file associations from the registry? (yes/no)'
	if ($proceedRemove -eq 'yes') {
		Start-Process cmd.exe -ArgumentList "/C $ENV:Temp\chocolatey\mpv\mpv-install-master\mpv-uninstall.bat" -Verb Runas
	}
}
