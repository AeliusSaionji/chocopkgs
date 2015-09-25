$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
Remove-Item -Path "$ENV:ChocolateyInstall\bin\mpv.exe"
Remove-Item -Path "$ENV:ChocolateyInstall\bin\mpv.com"
# TODO Change this test to directly probe the registry
If (Test-Path -Path "$ENV:ChocolateyInstall\mpv-uninstall.bat") {
	$proceedremove = Read-Host 'Do you wish to unrergister mpv file associations from the registry? (yes/no)'
	if ($proceedremove -eq 'yes') {
		Start-Process cmd.exe -ArgumentList "/C $toolsDir\mpv-uninstall.bat" -Verb Runas
	}
}
