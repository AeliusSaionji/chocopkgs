$packageName = 'Honeyview.portable'
$url = 'https://dl.bandisoft.com/honeyview/HONEYVIEW-PORTABLE.ZIP'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$checksum = '{{Checksum}}'
$checksumType = 'SHA512'

Install-ChocolateyZipPackage $packageName $url $toolsDir `
-Checksum $checksum -ChecksumType $checksumType
