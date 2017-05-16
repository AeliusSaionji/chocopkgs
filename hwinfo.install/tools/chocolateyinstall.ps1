$packageName = 'HWiNFO.install'
$fileType = 'exe'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
$url = 'https://www.hwinfo.com/files/hw32_550.exe'
$url64 = 'https://www.hwinfo.com/files/hw64_550.exe'
$checksum = '80bd0dcb98893d9ba6bc02de8ac5779e94b2ef65def6259433aea4daeb297847'
$checksum64 = '19e9e8f99db442ba5dedf51b5caf181979a4b445e6449eaf313d6501ef9012ce'
$checksumType = ''

$options =
@{
  Headers = @{
    Referer = 'https://www.hwinfo.com/download.php';
  }
}


Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64 `
-checksum $checksum -checksumType $checksumType -checksum64 $checksum64 -Options $options
# Kill the process after it starts- there is no way to prevent autostart after install
Get-Process | Where { $_.name -eq 'HWiNFO64' } | Stop-Process
Get-Process | Where { $_.name -eq 'HWiNFO32' } | Stop-Process
