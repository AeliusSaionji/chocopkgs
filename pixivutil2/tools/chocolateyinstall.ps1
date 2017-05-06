$packageName = 'PixivUtil2'
$version = '{{PackageVersion}}'
$version = $version.Replace('.','')
$unzipLocation = Join-Path "$(Get-BinRoot)" "$packageName"
$url = "https://github.com/Nandaka/PixivUtil2/releases/download/v$version/pixivutil$version.7z"
$checksum = '{{Checksum}}'
$checksumType = 'SHA512'

Install-ChocolateyZipPackage $packageName $url $unzipLocation `
-Checksum $checksum -ChecksumType $checksumType

$ProgsFolder = [environment]::getfolderpath('Programs')
If ( Test-ProcessAdminRights ) { $ProgsFolder = [environment]::getfolderpath('CommonPrograms') }
Install-ChocolateyShortcut -shortcutFilePath "$ProgsFolder\PixivUtil2.lnk" -targetPath "$unzipLocation\PixivUtil2.exe" -WorkingDirectory "$unzipLocation"
