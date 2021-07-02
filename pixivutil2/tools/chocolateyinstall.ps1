$packageName = 'PixivUtil2'
$unzipLocation = Join-Path "$(Get-ToolsLocation)" "$packageName"
$url = 'https://github.com/Nandaka/PixivUtil2/releases/download/v20210702/pixivutil20210702.zip'
$checksum = '10fab3245175fce17d6d15c6e766ad6027f74f49bc9fef78fb2aa5aaf0c28f58'
$checksumType = 'sha256'

Install-ChocolateyZipPackage $packageName $url $unzipLocation `
-Checksum $checksum -ChecksumType $checksumType

$ProgsFolder = [environment]::getfolderpath('Programs')
If ( Test-ProcessAdminRights ) { $ProgsFolder = [environment]::getfolderpath('CommonPrograms') }
Install-ChocolateyShortcut -shortcutFilePath "$ProgsFolder\PixivUtil2.lnk" -targetPath "$unzipLocation\PixivUtil2.exe" -WorkingDirectory "$unzipLocation"
