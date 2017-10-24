$packageName = 'HWiNFO.install'
$fileType = 'exe'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
$url = 'https://www.hwinfo.com/files/hw32_558.exe'
$url64 = 'https://www.hwinfo.com/files/hw64_558.exe'
$checksum = '42572A109C0A6204016BD7A8A2E56F91E06ADA27456A48D7B04470E319421C0A'
$checksum64 = '4B6A6E045740A80EA4F7BD2C94CEB162980D13C7736455FD13691AEB53195D57'
$checksumType = 'sha256'

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
