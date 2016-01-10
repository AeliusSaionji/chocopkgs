# Chocolatey doesn't clean up after the powershell install function
Remove-Item -Path "$ENV:ChocolateyInstall\bin\TidyStart.bat" -ErrorAction SilentlyContinue
