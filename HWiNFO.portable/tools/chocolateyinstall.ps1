$packageName = 'HWiNFO.portable'
$version = '{{PackageVersion}}'
$version = $version.Replace(".","")
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = "ftp://ftp.sac.sk/sac/utildiag/hw32_$version.zip"
$url64 = "ftp://ftp.sac.sk/sac/utildiag/hw64_$version.zip"
$checksum = '{{Checksum}}'
$checksum64 = '{{Checksumx64}}'
$checksumType = 'SHA512'

$options =
@{
  Headers = @{
    Referer = 'https://www.hwinfo.com/download.php';
  }
}

Install-ChocolateyZipPackage $packageName $url $toolsDir $url64 `
-checksum $checksum -checksumType $checksumType -checksum64 $checksum64 -Options $options
