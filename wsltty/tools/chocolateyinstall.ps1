$packageName = 'wsltty'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$filePath = Get-Item "$toolsdir\*install.exe"

# Extract installer to temp
Start-Process -FilePath "$filePath" -ArgumentList "/T:$ENV:TEMP\wslttyinstall /C /Q" -WorkingDirectory "$toolsdir" -Wait
# Run install.bat
Start-Process -FilePath "$ENV:TEMP\wslttyinstall\install.bat" -ArgumentList "$toolsDir" -WorkingDirectory "$ENV:TEMP\wslttyinstall" -Wait
# Remove installer
Remove-Item -Force -ea 0 "$filePath"
# Generate *.exe.ignore
gi "$toolsDir\bin\*.exe" | % { New-Item "$($_.FullName).ignore" -type File }