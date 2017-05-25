$packageName = 'HWiNFO.portable'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://www.hwinfo.com/files/hw32_552.zip'
$url64 = 'https://www.hwinfo.com/files/hw64_552.zip'
$checksum = '5168cc1e313e5de56a1067f883e0a8cb75e8b7ca86b08c3154f47c5ed40bd587'
$checksum64 = '1ecfa7435178d64ba970ab4bf8db71ac1e050b12d909975c044aac6e780673ff'
$checksumType = 'sha256'

$options =
@{
  Headers = @{
    Referer = 'https://www.hwinfo.com/download.php';
  }
}

Install-ChocolateyZipPackage $packageName $url $toolsDir $url64 `
-checksum $checksum -checksumType $checksumType -checksum64 $checksum64 -Options $options
