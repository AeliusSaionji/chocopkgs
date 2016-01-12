$packageName = 'Mupen64Plus-Qt'
$version = '{{PackageVersion}}'
$url = "https://github.com/dh4/mupen64plus-qt/releases/download/$version/mupen64plus-qt_win_$version.zip"
$fileFullPath = "$ENV:TEMP\chocolatey\$packageName\$packageName.zip"
$destination = "$ENV:ChocolateyInstall\lib\mupen64plus\tools"

Get-ChocolateyWebFile $packageName $fileFullPath $url
Get-ChocolateyUnzip $fileFullPath $destination
$csm = [environment]::getfolderpath('CommonStartMenu')
$usm = [environment]::getfolderpath('StartMenu')
Install-ChocolateyShortcut -shortcutFilePath "$csm\Programs\Mupen64Plus-Qt.lnk" -targetPath "$destination\mupen64plus-qt.exe"
Install-ChocolateyShortcut -shortcutFilePath "$usm\Programs\Mupen64Plus-Qt.lnk" -targetPath "$destination\mupen64plus-qt.exe"
