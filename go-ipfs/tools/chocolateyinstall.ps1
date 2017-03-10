$packageName= 'go-ipfs'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$version = '{{PackageVersion}}'
$url        = "https://dist.ipfs.io/go-ipfs/v${version}/go-ipfs_v${version}_windows-386.zip"
$url64      = "https://dist.ipfs.io/go-ipfs/v${version}/go-ipfs_v${version}_windows-amd64.zip"
$checksum = '{{Checksum}}'
$checksum64 = '{{Checksumx64}}'
$checksumType = 'SHA512'

Install-ChocolateyZipPackage $packageName $url $toolsDir $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64
