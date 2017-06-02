$packageName = 'HWiNFO.portable'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://www.hwinfo.com/files/hw32_552.zip'
$url64 = 'https://www.hwinfo.com/files/hw64_552.zip'
$checksum = '5168CC1E313E5DE56A1067F883E0A8CB75E8B7CA86B08C3154F47C5ED40BD587'
$checksum64 = 'C6C813741B6E36F34510884711EC849448E1DB83C17C44B8A5FF7BC7607248E5'
$checksumType = 'sha256'

$options =
@{
  Headers = @{
    Referer = 'https://www.hwinfo.com/download.php';
  }
}

Install-ChocolateyZipPackage $packageName $url $toolsDir $url64 `
-checksum $checksum -checksumType $checksumType -checksum64 $checksum64 -Options $options
