$packageName = 'HWiNFO.install'
$fileType = 'exe'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
$url = 'https://www.hwinfo.com/files/hw32_560.exe'
$url64 = 'https://www.hwinfo.com/files/hw64_560.exe'
$checksum = '6FF257236BF3618C784E23702FFB0FFD58A6A81D56D3E65A3E42CF38DC12D1B6'
$checksum64 = '1F0BDCE4C356DA6B3B7D7E654D1C6FF33053A84804BE26BFA7D62508ACE4F523'
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
