$packageName = 'qutebrowser.portable'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://github.com/qutebrowser/qutebrowser/releases/download/v1.3.2/qutebrowser-1.3.2-windows-standalone-win32.zip'
$url64 = 'https://github.com/qutebrowser/qutebrowser/releases/download/v1.3.2/qutebrowser-1.3.2-windows-standalone-amd64.zip'
$checksum = '4a4620320b21894ab609e2cab62a54cf2dff0e55292c169943549e80a39d3878'
$checksum64 = '80fe5bf293e96c9b1778e8a00f1e04ad712eac3b09f99c173607b78b2aa38578'
$checksumType = 'sha256'

Install-ChocolateyZipPackage $packageName $url $toolsDir $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64
