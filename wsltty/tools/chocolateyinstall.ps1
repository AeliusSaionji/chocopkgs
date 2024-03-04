$packageName = 'wsltty'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$filePath64 = Get-Item "$toolsDir\*x64.exe" 

# Extract installer
Start-Process -FilePath "$filePath64" -ArgumentList "/T:$toolsDir\wslttyinstall /C /Q" -WorkingDirectory "$toolsdir" -Wait
# Create shortcut
Install-ChocolateyShortcut `
 -ShortcutFilePath "$ENV:ALLUSERSPROFILE\Microsoft\Windows\Start Menu\Programs\WSL Generate Shortcuts.lnk" `
 -TargetPath "$toolsDir\wslttyinstall\install.bat" `
 -WorkingDirectory "$toolsDir\wslttyinstall"
# Remove installer
Remove-Item -Force -ea 0 "$filePath64"
# Generate *.exe.ignore
gi "$toolsDir\wslttyinstall\*.exe" | % { New-Item "$($_.FullName).ignore" -type File }

Write-Host "Make sure to run 'WSL Generate Shortcuts' to complete the update for your user account." -ForegroundColor red -BackgroundColor white
