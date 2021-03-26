$packageName = 'PixivUtil2'
$unzipLocation = Join-Path "$(Get-ToolsLocation)" "$packageName"
$url = 'https://github.com/Nandaka/PixivUtil2/releases/download/v20210326/pixivutil20210326.zip'
$checksum = 'c5e045c67e30b98312f32ead33ae79504cd71a8ab62df64afec70fa54b95ad9f'
$checksumType = 'sha256'

Install-ChocolateyZipPackage $packageName $url $unzipLocation `
-Checksum $checksum -ChecksumType $checksumType

$ProgsFolder = [environment]::getfolderpath('Programs')
If ( Test-ProcessAdminRights ) { $ProgsFolder = [environment]::getfolderpath('CommonPrograms') }
Install-ChocolateyShortcut -shortcutFilePath "$ProgsFolder\PixivUtil2.lnk" -targetPath "$unzipLocation\PixivUtil2.exe" -WorkingDirectory "$unzipLocation"
