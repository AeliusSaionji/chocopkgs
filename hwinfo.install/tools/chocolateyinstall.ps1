$packageName = 'HWiNFO.install'
$fileType = 'exe'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
$url = 'https://www.hwinfo.com/files/hw32_556.exe'
$url64 = 'https://www.hwinfo.com/files/hw64_556.exe'
$checksum = '230A43B61CA610B2C43B8E1E3CFE6A18A9500938BD6F4157892EBA45CF84E566'
$checksum64 = 'CDF243DD48334F8E0B1CEED152BFB9CCEC9678F157936DBA65130CC7D2DD1039'
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
