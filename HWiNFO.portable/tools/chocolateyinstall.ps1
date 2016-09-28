$packageName = 'HWiNFO.portable'
$version = '{{PackageVersion}}'
$version = $version.Replace(".","")
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = "ftp://ftp.sac.sk/sac/utildiag/hw32_$version.zip"
$url64 = "ftp://ftp.sac.sk/sac/utildiag/hw64_$version.zip"
$checksum = '{{Checksum}}'
$checksumType = 'SHA1'
$checksum64 = '{{Checksumx64}}'
$checksumType64 = 'SHA1'

Install-ChocolateyZipPackage $packageName $url $toolsDir $url64 -checksum $checksum -checksumType $checksumType -checksum64 $checksum64 -checksumType64 $checksumType64
