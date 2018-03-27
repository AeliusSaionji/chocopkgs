$packageName = 'PixivUtil2'
$unzipLocation = Join-Path "$(Get-BinRoot)" "$packageName"
$url = 'https://github.com/Nandaka/PixivUtil2/releases/download/v20180316/pixivutil20180316.7z'
$checksum = '442dc7f6e962f813e539f088036d6f1ab6aee98105e1d8b2a321b935d0a12d54'
$checksumType = 'sha256'

Install-ChocolateyZipPackage $packageName $url $unzipLocation `
-Checksum $checksum -ChecksumType $checksumType

$ProgsFolder = [environment]::getfolderpath('Programs')
If ( Test-ProcessAdminRights ) { $ProgsFolder = [environment]::getfolderpath('CommonPrograms') }
Install-ChocolateyShortcut -shortcutFilePath "$ProgsFolder\PixivUtil2.lnk" -targetPath "$unzipLocation\PixivUtil2.exe" -WorkingDirectory "$unzipLocation"
