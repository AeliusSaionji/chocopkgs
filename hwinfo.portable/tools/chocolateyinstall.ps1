$packageName = 'HWiNFO.portable'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://www.hwinfo.com/files/hw32_550.zip'
$url64 = 'https://www.hwinfo.com/files/hw64_550.zip'
$checksum = '4f60c4988f5594e318ce7b9b1eb094b4f01f00a58de7aba1c5f92a665ee0c7e2'
$checksum64 = 'ed547b922bae9c2a94a6d8fbf9cca760597d130fb64bf7fa0483e391b789f5ac'
$checksumType = 'sha256'

$options =
@{
  Headers = @{
    Referer = 'https://www.hwinfo.com/download.php';
  }
}

Install-ChocolateyZipPackage $packageName $url $toolsDir $url64 `
-checksum $checksum -checksumType $checksumType -checksum64 $checksum64 -Options $options
