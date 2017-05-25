$packageName = 'HWiNFO.install'
$fileType = 'exe'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
$url = 'https://www.hwinfo.com/files/hw32_552.exe'
$url64 = 'https://www.hwinfo.com/files/hw64_552.exe'
$checksum = 'f28fe66edf9a74c87e3d71d1f406aef5e991904afa567338284ed89a3aea4a3e'
$checksum64 = '1ecfa7435178d64ba970ab4bf8db71ac1e050b12d909975c044aac6e780673ff'
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
