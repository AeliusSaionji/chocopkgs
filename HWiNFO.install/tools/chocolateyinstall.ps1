$PSScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Definition
Import-Module "$PSScriptRoot\Get-UrlFromFosshub.ps1"

$packageName = 'HWiNFO.install'
$fileType = 'exe'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
$version = '{{PackageVersion}}'
$version = $version.Replace(".","")
$url = Get-UrlFromFosshub "http://www.fosshub.com/genLink/HWiNFO/hw32_$version.exe"
$url64 = Get-UrlFromFosshub "http://www.fosshub.com/genLink/HWiNFO/hw64_$version.exe"
$checksum = '{{Checksum}}'
$checksumType = 'SHA1'
$checksum64 = '{{Checksumx64}}'
$checksumType64 = 'SHA1'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64 -checksum $checksum -checksumType $checksumType -checksum64 $checksum64 -checksumType64 $checksumType64
# Kill the process after it starts- there is no way to prevent autostart after install
Get-Process | Where { $_.name -eq 'HWiNFO64' } | Stop-Process
