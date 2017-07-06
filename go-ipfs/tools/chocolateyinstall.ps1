$packageName= 'go-ipfs'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://dist.ipfs.io/go-ipfs/v0.4.10/go-ipfs_v0.4.10_windows-386.zip'
$url64      = 'https://dist.ipfs.io/go-ipfs/v0.4.10/go-ipfs_v0.4.10_windows-amd64.zip'
$checksum   = '814a739c1abf9038b77b22a6bbe3f4f2ae282e3919e36bc88375d9f9bffea01e'
$checksum64 = 'ab396d0c5ba583a28d2f2e788abd18e58893ccef18baf9780f54aca3186098be'
$checksumType = 'sha256'

Install-ChocolateyZipPackage $packageName $url $toolsDir $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64
