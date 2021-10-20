$packageName = 'PixivUtil2'
$unzipLocation = Join-Path "$(Get-ToolsLocation)" "$packageName"
$url = 'https://github.com/Nandaka/PixivUtil2/releases/download/v20211020/pixivutil20211020-win7.zip'
$checksum = '7d5da6583be90fd057d98d82cc030649a051bd835ef8bcb01dae5cb088b256f4'
$checksumType = 'sha256'

Install-ChocolateyZipPackage $packageName $url $unzipLocation `
-Checksum $checksum -ChecksumType $checksumType

$ProgsFolder = [environment]::getfolderpath('Programs')
If ( Test-ProcessAdminRights ) { $ProgsFolder = [environment]::getfolderpath('CommonPrograms') }
Install-ChocolateyShortcut -shortcutFilePath "$ProgsFolder\PixivUtil2.lnk" -targetPath "$unzipLocation\PixivUtil2.exe" -WorkingDirectory "$unzipLocation"
