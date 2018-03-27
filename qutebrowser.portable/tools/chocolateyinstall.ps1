$packageName = 'qutebrowser.portable'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://github.com/qutebrowser/qutebrowser/releases/download/v1.2.1/qutebrowser-1.2.1-windows-standalone-win32.zip'
$url64 = 'https://github.com/qutebrowser/qutebrowser/releases/download/v1.2.1/qutebrowser-1.2.1-windows-standalone-amd64.zip'
$checksum = 'bc723a5975755ee912c6ad692133001cabfe5f7ca0c0a74e197c8708608a2b2f'
$checksum64 = '2759d8099cbc9edcc162e2a4c91bd918f1d03af72c9ba160755fceec440b722c'
$checksumType = 'sha256'

Install-ChocolateyZipPackage $packageName $url $toolsDir $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64
