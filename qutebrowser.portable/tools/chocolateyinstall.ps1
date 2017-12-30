$packageName = 'qutebrowser.portable'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$version = '{{PackageVersion}}'
$url = 'https://github.com/qutebrowser/qutebrowser/releases/download/v1.0.4/qutebrowser-1.0.4-windows-standalone-win32.zip'
$url64 = 'https://github.com/qutebrowser/qutebrowser/releases/download/v1.0.4/qutebrowser-1.0.4-windows-standalone-amd64.zip'
$checksum = '6593b08ce29321e5f77e7c98e6f3fdfc7a2c0537a87487c47c46dc9ebcbbde1c'
$checksum64 = '526b040576434641d574a72bf49b0f5503b6100efed7a8383bf798a9ca4a3d30'
$checksumType = 'sha256'

Install-ChocolateyZipPackage $packageName $url $toolsDir $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64
