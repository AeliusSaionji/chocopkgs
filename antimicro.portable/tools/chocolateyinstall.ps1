$packageName = 'antimicro.portable'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$version     = '{{PackageVersion}}'
$url         = "https://github.com/AntiMicro/antimicro/releases/download/$version/antimicro-$version-win32.portable.zip"
$checksum    = '{{Checksum}}'
$checksumType= 'SHA512'

Install-ChocolateyZipPackage -PackageName $packageName -Url $url -UnzipLocation $toolsDir `
-Checksum $checksum -ChecksumType $checksumType
