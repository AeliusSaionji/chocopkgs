$packageName = 'qutebrowser.portable'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://github.com/qutebrowser/qutebrowser/releases/download/v1.1.1/qutebrowser-1.1.1-windows-standalone-win32.zip'
$url64 = 'https://github.com/qutebrowser/qutebrowser/releases/download/v1.1.1/qutebrowser-1.1.1-windows-standalone-amd64.zip'
$checksum = '27a0fae3706c8c4b5381f43b91e57bd3eb0c9f4a6594b97d84c22e01211fa44c'
$checksum64 = '9c9693e7b7c28266b4edcf6de90ae15af3bde4aed4359149a25f6942f3b186a4'
$checksumType = 'sha256'

Install-ChocolateyZipPackage $packageName $url $toolsDir $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64
