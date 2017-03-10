$packageName = 'Locale-Emulator'
$version = '{{PackageVersion}}'
$url = "https://github.com/xupefei/Locale-Emulator/releases/download/v${version}/Locale.Emulator.${version}.zip"
$destination = Join-Path "$(Get-BinRoot)" "$packageName"
$checksum = '{{Checksum}}'
$checksumType = 'SHA512'

Install-ChocolateyZipPackage $packageName $url $destination `
-Checksum $checksum -ChecksumType $checksumType
