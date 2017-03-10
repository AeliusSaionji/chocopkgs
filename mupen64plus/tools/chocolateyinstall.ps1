$packageName = 'mupen64plus'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$version     = '{{PackageVersion}}'
$url         = "https://github.com/mupen64plus/mupen64plus-core/releases/download/$version/mupen64plus-bundle-win32-$version.zip"
$checksum = '{{Checksum}}'
$checksumType = 'SHA512'

Install-ChocolateyZipPackage $packageName $url $toolsDir `
-Checksum $checksum -ChecksumType $checksumType
