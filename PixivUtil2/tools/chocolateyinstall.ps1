$packageName = 'PixivUtil2'
$version = '{{PackageVersion}}'
$versionWithoutDots = $version.Replace('.','')
$unzipLocation = Join-Path "$(Get-BinRoot)" "$packageName"
$url = "https://github.com/Nandaka/PixivUtil2/releases/download/v$versionWithoutDots/pixivutil$versionWithoutDots.7z"

Install-ChocolateyZipPackage $packageName $url $unzipLocation

$commProgs = [environment]::getfolderpath('CommonPrograms')
$userProgs = [environment]::getfolderpath('Programs')
Install-ChocolateyShortcut -shortcutFilePath "$commProgs\PixivUtil2.lnk" -targetPath "$unzipLocation\PixivUtil2.exe" -WorkingDirectory "$unzipLocation"
Install-ChocolateyShortcut -shortcutFilePath "$userProgs\PixivUtil2.lnk" -targetPath "$unzipLocation\PixivUtil2.exe" -WorkingDirectory "$unzipLocation"
