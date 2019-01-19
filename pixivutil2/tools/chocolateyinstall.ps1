$packageName = 'PixivUtil2'
$unzipLocation = Join-Path "$(Get-BinRoot)" "$packageName"
$url = 'https://github.com/Nandaka/PixivUtil2/releases/download/v20190119/pixivutil2019119.zip'
$checksum = 'af8d9011cf61bf5c75a6abeaadb9f8e0f7802cf302bb029820ee199e84879097'
$checksumType = 'sha256'

Install-ChocolateyZipPackage $packageName $url $unzipLocation `
-Checksum $checksum -ChecksumType $checksumType

$ProgsFolder = [environment]::getfolderpath('Programs')
If ( Test-ProcessAdminRights ) { $ProgsFolder = [environment]::getfolderpath('CommonPrograms') }
Install-ChocolateyShortcut -shortcutFilePath "$ProgsFolder\PixivUtil2.lnk" -targetPath "$unzipLocation\PixivUtil2.exe" -WorkingDirectory "$unzipLocation"
