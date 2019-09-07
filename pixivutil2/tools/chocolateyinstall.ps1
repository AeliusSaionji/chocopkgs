$packageName = 'PixivUtil2'
$unzipLocation = Join-Path "$(Get-BinRoot)" "$packageName"
$url = 'https://github.com/Nandaka/PixivUtil2/releases/download/v20190907/pixivutil20190907.zip'
$checksum = '91fb0093885c69510a50e8b137b53f866d988e6e470d67b4982c4662fce6074a'
$checksumType = 'sha256'

Install-ChocolateyZipPackage $packageName $url $unzipLocation `
-Checksum $checksum -ChecksumType $checksumType

$ProgsFolder = [environment]::getfolderpath('Programs')
If ( Test-ProcessAdminRights ) { $ProgsFolder = [environment]::getfolderpath('CommonPrograms') }
Install-ChocolateyShortcut -shortcutFilePath "$ProgsFolder\PixivUtil2.lnk" -targetPath "$unzipLocation\PixivUtil2.exe" -WorkingDirectory "$unzipLocation"
