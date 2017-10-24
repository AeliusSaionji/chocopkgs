$packageName = 'qutebrowser.portable'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$version = '{{PackageVersion}}'
$url = 'https://github.com/qutebrowser/qutebrowser/releases/download/v1.0.2/qutebrowser-1.0.2-windows-standalone-win32.zip'
$url64 = 'https://github.com/qutebrowser/qutebrowser/releases/download/v1.0.2/qutebrowser-1.0.2-windows-standalone-amd64.zip'
$checksum = 'b7e7acbbb0e8a7d71c3f3bea5f80a6be03012347ecdce2192e403da70ae71b64'
$checksum64 = '905e1373431ef109f7b1faff0d9a6424690f0a1769b1a03548f1175b3a178f6b'
$checksumType = 'sha256'

Install-ChocolateyZipPackage $packageName $url $toolsDir $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64
