$packageName = 'VcXsrv'
$installerType = 'exe'
$silentArgs = '/S'
$version = '{{PackageVersion}}'
$url = "https://sourceforge.net/projects/vcxsrv/files/vcxsrv/${version}/vcxsrv.${version}.installer.exe/download"
$url64 = "https://sourceforge.net/projects/vcxsrv/files/vcxsrv/${version}/vcxsrv-64.${version}.installer.exe/download"
$checksum = '{{Checksum}}'
$checksum64 = '{{Checksumx64}}'
$checksumType = 'SHA512'

Install-ChocolateyPackage $packageName $installerType $silentArgs $url $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64
