$packageName = 'HWiNFO.portable'
$version = '{{PackageVersion}}'
$version = $version.Replace(".","")
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = "ftp://ftp.sac.sk/sac/utildiag/hw32_$version.zip"
$url64 = "ftp://ftp.sac.sk/sac/utildiag/hw64_$version.zip"
$checksum = '{{Checksum}}'
$checksumType = 'sha512'
$checksum64 = '{{Checksumx64}}'

Install-ChocolateyZipPackage $packageName $url $toolsDir $url64 -checksum $checksum -checksumType $checksumType -checksum64 $checksum64
