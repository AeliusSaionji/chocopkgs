$packageName = 'HWiNFO.portable'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://www.hwinfo.com/files/hw32_556.zip'
$url64 = 'https://www.hwinfo.com/files/hw64_556.zip'
$checksum = '8DDCA8E0971BA608717E2DC93E500986409ECCE0B5EE3F38BBAD693917114F21'
$checksum64 = '88B49BCD63D20411B49E949A1678B126A5ED51CA5A0222C70DC4EC6721BC314E'
$checksumType = 'sha256'

$options =
@{
  Headers = @{
    Referer = 'https://www.hwinfo.com/download.php';
  }
}

Install-ChocolateyZipPackage $packageName $url $toolsDir $url64 `
-checksum $checksum -checksumType $checksumType -checksum64 $checksum64 -Options $options
