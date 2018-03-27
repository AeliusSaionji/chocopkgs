$packageName = 'wsltty'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$filePath = Get-Item "$toolsdir\*.exe"

# Extract installer
Start-Process -FilePath "$filePath" -ArgumentList "/T:$toolsDir\wslttyinstall /C /Q" -WorkingDirectory "$toolsdir" -Wait
# Create shortcut
Install-ChocolateyShortcut `
 -ShortcutFilePath "$ENV:ALLUSERSPROFILE\Microsoft\Windows\Start Menu\Programs\WSL Generate Shortcuts.lnk" `
 -TargetPath "$toolsDir\wslttyinstall\install.bat" `
 -WorkingDirectory "$toolsDir\wslttyinstall"
# Remove installer
Remove-Item -Force -ea 0 "$filePath"
# Generate *.exe.ignore
gi "$toolsDir\wslttyinstall\*.exe" | % { New-Item "$($_.FullName).ignore" -type File }
