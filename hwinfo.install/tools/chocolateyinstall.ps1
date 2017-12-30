$packageName = 'HWiNFO.install'
$fileType = 'exe'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
$url = 'https://www.hwinfo.com/files/hw32_570.exe'
$url64 = 'https://www.hwinfo.com/files/hw64_570.exe'
$checksum = '59B308CDD179ABC61F677636B05ABC8B990D3AA4AF418AF27F67FD3E381D0D0A'
$checksum64 = 'A464412D047867FD01817E4AEC724D8B4821D8E90E527513A6B3ABB595A367CF'
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
