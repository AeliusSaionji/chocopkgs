$packageName = 'Locale-Emulator'
$version = '{{PackageVersion}}'
$url = "https://github.com/xupefei/Locale-Emulator/releases/download/v${version}/Locale.Emulator.${version}.zip"
$destination = Join-Path "$(Get-BinRoot)" "$packageName"

Install-ChocolateyZipPackage $packageName $url $destination
