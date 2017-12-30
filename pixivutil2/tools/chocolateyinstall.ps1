$packageName = 'PixivUtil2'
$unzipLocation = Join-Path "$(Get-BinRoot)" "$packageName"
$url = 'https://github.com/Nandaka/PixivUtil2/releases/download/v20171127/pixivutil20171127.7z'
$checksum = 'a8366f42bfe55646a956c4177c2df029c2e4aecb535009ff1e38b028d9e59fdc'
$checksumType = 'sha256'

Install-ChocolateyZipPackage $packageName $url $unzipLocation `
-Checksum $checksum -ChecksumType $checksumType

$ProgsFolder = [environment]::getfolderpath('Programs')
If ( Test-ProcessAdminRights ) { $ProgsFolder = [environment]::getfolderpath('CommonPrograms') }
Install-ChocolateyShortcut -shortcutFilePath "$ProgsFolder\PixivUtil2.lnk" -targetPath "$unzipLocation\PixivUtil2.exe" -WorkingDirectory "$unzipLocation"
