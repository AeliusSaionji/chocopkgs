$packageName= 'go-ipfs'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url64      = 'https://dist.ipfs.io/go-ipfs/v0.4.13/go-ipfs_v0.4.13_windows-amd64.zip'

$checksum64 = '628ecad79307a6129116dc96c6c99ad20a33c39b573bff5dab4cceb065bcbead'
$checksumType64 = 'sha256'

Install-ChocolateyZipPackage $packageName -UnzipLocation $toolsDir -Url64bit $url64 `
-ChecksumType64 $checksumType64 -Checksum64 $checksum64
