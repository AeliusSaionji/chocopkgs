$packageName = 'HWiNFO.install'
$fileType = 'exe'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
$url = 'https://www.hwinfo.com/files/hw32_552.exe'
$url64 = 'https://www.hwinfo.com/files/hw64_552.exe'
$checksum = 'F28FE66EDF9A74C87E3D71D1F406AEF5E991904AFA567338284ED89A3AEA4A3E'
$checksum64 = '5300E70CA5AB7DBB7FC242C2FAE795EA495D68C9DFAB899BE5A933330631CD1C'
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
