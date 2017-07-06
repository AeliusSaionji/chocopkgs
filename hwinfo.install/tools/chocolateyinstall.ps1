$packageName = 'HWiNFO.install'
$fileType = 'exe'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
$url = 'https://www.hwinfo.com/files/hw32_554.exe'
$url64 = 'https://www.hwinfo.com/files/hw64_554.exe'
$checksum = 'D7C708817D18AC14AC38994E8B2096EF0A2684ACBF0BA2536C419C9E42CE70E0'
$checksum64 = '93BCBC4E8EA5AB51C8F84F923A74DB7FD04481055316004774CAECEEC592A2DE'
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
