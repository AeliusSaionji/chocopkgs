$packageName= 'go-ipfs'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://dist.ipfs.io/go-ipfs/v0.4.9/go-ipfs_v0.4.9_windows-386.zip'
$url64      = 'https://dist.ipfs.io/go-ipfs/v0.4.9/go-ipfs_v0.4.9_windows-amd64.zip'
$checksum   = 'bfdeb67a2bf4c8d788ec28b3d4f994786a4b25f83350ef7794b99de9631dc886'
$checksum64 = '203f444285dbc50d202077c498932d890dd1ae67cc0e46806517bc7fed087cb9'
$checksumType = 'sha256'

Install-ChocolateyZipPackage $packageName $url $toolsDir $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64
