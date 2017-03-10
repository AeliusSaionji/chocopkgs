$packageName = 'Mupen64Plus-Qt'
$version = '{{PackageVersion}}'
$url = "https://github.com/dh4/mupen64plus-qt/releases/download/$version/mupen64plus-qt_win_$version.zip"
$fileFullPath = "$ENV:TEMP\chocolatey\$packageName\$packageName.zip"
$destination = "$ENV:ChocolateyInstall\lib\mupen64plus\tools"
$checksum = '{{Checksum}}'
$checksumType = 'SHA512'

Get-ChocolateyWebFile $packageName $fileFullPath $url `
-Checksum $checksum -ChecksumType $checksumType

Get-ChocolateyUnzip $fileFullPath $destination
$commProgs = [environment]::getfolderpath('CommonPrograms')
$userProgs = [environment]::getfolderpath('Programs')
Install-ChocolateyShortcut -shortcutFilePath "$commProgs\Mupen64Plus-Qt.lnk" -targetPath "$destination\mupen64plus-qt.exe"
Install-ChocolateyShortcut -shortcutFilePath "$userProgs\Mupen64Plus-Qt.lnk" -targetPath "$destination\mupen64plus-qt.exe"
