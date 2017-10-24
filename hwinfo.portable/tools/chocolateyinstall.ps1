$packageName = 'HWiNFO.portable'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://www.hwinfo.com/files/hw32_558.zip'
$url64 = 'https://www.hwinfo.com/files/hw64_558.zip'
$checksum = '422FB9F16E8E9D66063C9F141496737D1F1B2A8F7A0265C069953E466AB5C6D9'
$checksum64 = '452B33F88B9E46116231A70EBDE4E6FBF6DE1E749FA65C46E2D5DC19BD632711'
$checksumType = 'sha256'

$options =
@{
  Headers = @{
    Referer = 'https://www.hwinfo.com/download.php';
  }
}

Install-ChocolateyZipPackage $packageName $url $toolsDir $url64 `
-checksum $checksum -checksumType $checksumType -checksum64 $checksum64 -Options $options
