$packageName = 'PixivUtil2'
$unzipLocation = Join-Path "$(Get-ToolsLocation)" "$packageName"
$url = 'https://github.com/Nandaka/PixivUtil2/releases/download/v20200712/pixivutil20200712.zip'
$checksum = '90e4d4ea9feeb0d6c1b0b9671d4c3f014105fb9e8bb8d6b7ad1ec1e4b5c70139'
$checksumType = 'sha256'

Install-ChocolateyZipPackage $packageName $url $unzipLocation `
-Checksum $checksum -ChecksumType $checksumType

$ProgsFolder = [environment]::getfolderpath('Programs')
If ( Test-ProcessAdminRights ) { $ProgsFolder = [environment]::getfolderpath('CommonPrograms') }
Install-ChocolateyShortcut -shortcutFilePath "$ProgsFolder\PixivUtil2.lnk" -targetPath "$unzipLocation\PixivUtil2.exe" -WorkingDirectory "$unzipLocation"
