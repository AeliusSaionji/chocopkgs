$PSScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Definition
Import-Module (Join-Path $PSScriptRoot 'get-fosshublinks.ps1')

$packageName = 'HWiNFO.portable'
$version = '{{PackageVersion}}'
$version = $version.Replace(".","")
$url = Get-FosshubLinks "http://www.fosshub.com/genLink/HWiNFO/hw32_$version.zip"
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64 = Get-FosshubLinks "http://www.fosshub.com/genLink/HWiNFO/hw64_$version.zip"
$checksum = '{{Checksum}}'
$checksumType = 'SHA1'
$checksum64 = '{{Checksumx64}}'
$checksumType64 = 'SHA1'

Install-ChocolateyPackage $packageName $url $toolsDir $url64 -checksum $checksum -checksumType $checksumType -checksum64 $checksum64 -checksumType64 $checksumType64
