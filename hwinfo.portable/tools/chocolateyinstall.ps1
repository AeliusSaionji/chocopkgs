$packageName = 'HWiNFO.portable'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://www.hwinfo.com/files/hw32_570.zip'
$url64 = 'https://www.hwinfo.com/files/hw64_570.zip'
$checksum = 'C4A5CAFF9F8B65D9EE0CFB9D78FDA4FC13B0B94BDF55736881D872FB01AF7A6B'
$checksum64 = '47D6E19023C568375C78AB9691CEF2DFD27FEC491334889BD5FBAC5D8681D797'
$checksumType = 'sha256'

$options =
@{
  Headers = @{
    Referer = 'https://www.hwinfo.com/download.php';
  }
}

Install-ChocolateyZipPackage $packageName $url $toolsDir $url64 `
-checksum $checksum -checksumType $checksumType -checksum64 $checksum64 -Options $options
