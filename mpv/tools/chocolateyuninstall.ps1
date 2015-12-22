$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
Remove-Item -Path "$ENV:ChocolateyInstall\bin\mpv.exe"
Remove-Item -Path "$ENV:ChocolateyInstall\bin\mpv.com"
# TODO Change this test to directly probe the registry
If (Test-Path -Path "$ENV:Temp\chocolatey\mpv\mpv-install-master\mpv-uninstall.bat") {
	# Interactivity is frowned upon? Upon request I guess I could separate this into a portable/install tripackage, but I don't like that.
	#$proceedRemove = Read-Host 'Do you wish to unrergister mpv file associations from the registry? (yes/no)'
	#if ($proceedRemove -eq 'yes') {
		Start-ChocolateyProcessAsAdmin "/K $toolsDir\mpv-uninstall.bat" 'cmd.exe' -validExitCodes '0'
	#}
}
