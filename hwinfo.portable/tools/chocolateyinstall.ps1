$packageName = 'HWiNFO.portable'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://www.hwinfo.com/files/hw32_560.zip'
$url64 = 'https://www.hwinfo.com/files/hw64_560.zip'
$checksum = 'B435EF0330B44C79894A26F73FAB33AE8314B14BBE6EB1921BCB4B472EECCA35'
$checksum64 = 'E737F0F452BAB64CDB57A34B15FB8F4DB369B51ABADA271CA2E850641B583A14'
$checksumType = 'sha256'

$options =
@{
  Headers = @{
    Referer = 'https://www.hwinfo.com/download.php';
  }
}

Install-ChocolateyZipPackage $packageName $url $toolsDir $url64 `
-checksum $checksum -checksumType $checksumType -checksum64 $checksum64 -Options $options
