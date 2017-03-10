$packageName = 'qutebrowser.portable'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$version = '{{PackageVersion}}'
$url = "https://github.com/The-Compiler/qutebrowser/releases/download/v$version/qutebrowser-$version-windows-standalone-win32.zip"
$url64 = "https://github.com/The-Compiler/qutebrowser/releases/download/v$version/qutebrowser-$version-windows-standalone-amd64.zip"
$checksum = '{{Checksum}}'
$checksum64 = '{{Checksumx64}}'
$checksumType = 'SHA512'

Install-ChocolateyZipPackage $packageName $url $toolsDir $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64
