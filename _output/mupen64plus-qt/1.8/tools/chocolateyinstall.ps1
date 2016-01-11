$packageName = 'Mupen64Plus-Qt'
$version = '1.8'
$url = "https://github.com/dh4/mupen64plus-qt/releases/download/$version/mupen64plus-qt_win_$version.zip"
$fileFullPath = "$ENV:TEMP\chocolatey\$packageName\$packageName.zip"
$destination = "$ENV:ChocolateyInstall\lib\mupen64plus\tools"

Get-ChocolateyWebFile $packageName $fileFullPath $url
Get-ChocolateyUnzip $fileFullPath $destination
Install-ChocolateyShortcut -shortcutFilePath "$ENV:ALLUSERSPROFILE\Microsoft\Windows\Start Menu\Programs\Mupen64Plus-Qt.lnk" -targetPath "$destination\mupen64plus-qt.exe"
Install-ChocolateyShortcut -shortcutFilePath "$ENV:APPDATA\Microsoft\Windows\Start Menu\Programs\Mupen64Plus-Qt.lnk" -targetPath "$destination\mupen64plus-qt.exe"
