$packageName= 'go-ipfs'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url64      = 'https://dist.ipfs.io/go-ipfs/v0.4.14/go-ipfs_v0.4.14_windows-amd64.zip'

$checksum64 = '38a0abd9a610670d4a3315384bfb7e77dbdac010da6b6394cc5ac96762e0f67d'
$checksumType64 = 'sha256'

Install-ChocolateyZipPackage $packageName -UnzipLocation $toolsDir -Url64bit $url64 `
-ChecksumType64 $checksumType64 -Checksum64 $checksum64
