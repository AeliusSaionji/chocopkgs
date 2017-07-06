$packageName = 'qutebrowser.portable'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$version = '{{PackageVersion}}'
$url = 'https://github.com/qutebrowser/qutebrowser/releases/download/v0.11.0/qutebrowser-0.11.0-windows-standalone-win32.zip'
$url64 = 'https://github.com/qutebrowser/qutebrowser/releases/download/v0.11.0/qutebrowser-0.11.0-windows-standalone-amd64.zip'
$checksum = 'dacbf234e2eddf846b38da1fd8a39c1d25b5c14d14661e9a66e54c8adef3da79'
$checksum64 = 'd9c1ea5c16d19bcbbdc63bd6fe7f155c44508652339e882e6e0f4b99a1a9b4c7'
$checksumType = 'sha256'

Install-ChocolateyZipPackage $packageName $url $toolsDir $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64
