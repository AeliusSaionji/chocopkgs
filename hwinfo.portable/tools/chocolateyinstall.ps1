$packageName = 'HWiNFO.portable'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://www.hwinfo.com/files/hw32_554.zip'
$url64 = 'https://www.hwinfo.com/files/hw64_554.zip'
$checksum = 'A6E05B23425038B06D024C5CA3D846C4AD5957D1DF8C259F83A585C427FB53F9'
$checksum64 = '745B1302B62CCC0B0EF4784FBF264AF52991F6E81DC28F60C6F169226844438A'
$checksumType = 'sha256'

$options =
@{
  Headers = @{
    Referer = 'https://www.hwinfo.com/download.php';
  }
}

Install-ChocolateyZipPackage $packageName $url $toolsDir $url64 `
-checksum $checksum -checksumType $checksumType -checksum64 $checksum64 -Options $options
