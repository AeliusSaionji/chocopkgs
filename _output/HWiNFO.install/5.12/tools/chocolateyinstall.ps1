$PSScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Definition
Import-Module "$PSScriptRoot\Get-UrlFromFosshub.ps1"

$packageName = 'HWiNFO.install'
$fileType = 'exe'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
$version = '5.12'
$version = $version.Replace(".","")
$url = Get-UrlFromFosshub "http://www.fosshub.com/genLink/HWiNFO/hw32_$version.exe"
$url64 = Get-UrlFromFosshub "http://www.fosshub.com/genLink/HWiNFO/hw64_$version.exe"
$checksum = '1cd818345b3041664c0e853f82d856faf695fd91'
$checksumType = 'SHA1'
$checksum64 = '5b1571a5b1a89a946a57367e0687c998ff5b9a3e'
$checksumType64 = 'SHA1'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64 -checksum $checksum -checksumType $checksumType -checksum64 $checksum64 -checksumType64 $checksumType64
# Kill the process after it starts- there is no way to prevent autostart after install
Get-Process | Where { $_.name -eq 'HWiNFO64' } | Stop-Process
Get-Process | Where { $_.name -eq 'HWiNFO32' } | Stop-Process
