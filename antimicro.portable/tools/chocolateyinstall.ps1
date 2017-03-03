$packageName = 'antimicro.portable'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$version     = '{{PackageVersion}}'
$url         = "https://github.com/AntiMicro/antimicro/releases/download/$version/antimicro-$version-win32.portable.zip"
$checksum    = 'e29fb029cb1a257761c5a4a0795cca71c567e153aae850e80321197f1f918e8a5b31d423c895e85adb65fb20b20cfb9939b506f739eaa6506d2aeaa33f00be31'
$checksumType= 'sha512'

Install-ChocolateyZipPackage -PackageName $packageName -Url $url -UnzipLocation $toolsDir -Checksum $checksum -ChecksumType $checksumType
