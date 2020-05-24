$packageName = 'PixivUtil2'
$unzipLocation = Join-Path "$(Get-ToolsLocation)" "$packageName"
$url = 'https://github.com/Nandaka/PixivUtil2/releases/download/v20200524/pixivutil20200524.zip'
$checksum = '9dfab98c38e29d927b76e737457c90848fa65d43f65502579c1425c9d9a63d47'
$checksumType = 'sha256'

Install-ChocolateyZipPackage $packageName $url $unzipLocation `
-Checksum $checksum -ChecksumType $checksumType

$ProgsFolder = [environment]::getfolderpath('Programs')
If ( Test-ProcessAdminRights ) { $ProgsFolder = [environment]::getfolderpath('CommonPrograms') }
Install-ChocolateyShortcut -shortcutFilePath "$ProgsFolder\PixivUtil2.lnk" -targetPath "$unzipLocation\PixivUtil2.exe" -WorkingDirectory "$unzipLocation"
