# Chocolatey doesn't clean up after its own powershell install function
If (Test-Path -Path "$ENV:ChocolateyInstall\bin\TidyStart.bat") {
	Remove-Item -Path "$ENV:ChocolateyInstall\bin\TidyStart.bat"
}
