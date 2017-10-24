$packageName= 'go-ipfs'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://dist.ipfs.io/go-ipfs/v0.4.11/go-ipfs_v0.4.11_windows-386.zip'
$url64      = 'https://dist.ipfs.io/go-ipfs/v0.4.11/go-ipfs_v0.4.11_windows-amd64.zip'
$checksum   = 'a30850f2412caf6ea5e343b895c910a9673d08d155b36abf0b4dcea062c148d8'
$checksum64 = '923afa2b1308244cb8739f4d625bd3e06839002b7463121735f12b645d45639a'
$checksumType = 'sha256'

Install-ChocolateyZipPackage $packageName $url $toolsDir $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64
