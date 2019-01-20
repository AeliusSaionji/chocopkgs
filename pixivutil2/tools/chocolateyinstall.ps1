$packageName = 'PixivUtil2'
$unzipLocation = Join-Path "$(Get-BinRoot)" "$packageName"
$url = 'https://github.com/Nandaka/PixivUtil2/releases/download/v20190120/pixivutil2019120.zip'
$checksum = '24920e2afff2d6fb98d909df8008fe8cdef63f73b26d624183ad6d1806f29e23'
$checksumType = 'sha256'

Install-ChocolateyZipPackage $packageName $url $unzipLocation `
-Checksum $checksum -ChecksumType $checksumType

$ProgsFolder = [environment]::getfolderpath('Programs')
If ( Test-ProcessAdminRights ) { $ProgsFolder = [environment]::getfolderpath('CommonPrograms') }
Install-ChocolateyShortcut -shortcutFilePath "$ProgsFolder\PixivUtil2.lnk" -targetPath "$unzipLocation\PixivUtil2.exe" -WorkingDirectory "$unzipLocation"
