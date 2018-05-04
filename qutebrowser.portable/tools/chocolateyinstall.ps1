$packageName = 'qutebrowser.portable'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://github.com/qutebrowser/qutebrowser/releases/download/v1.3.0/qutebrowser-1.3.0-windows-standalone-win32.zip'
$url64 = 'https://github.com/qutebrowser/qutebrowser/releases/download/v1.3.0/qutebrowser-1.3.0-windows-standalone-amd64.zip'
$checksum = 'cf6fac19622be05fd42109e18765d38ffb22419ef9cf42b85e2dfc352cc47899'
$checksum64 = 'ca52f2d33c7388dd60990f6339b0cbbf2a6d1bc80a401d9a48e6cb5f9d97b47e'
$checksumType = 'sha256'

Install-ChocolateyZipPackage $packageName $url $toolsDir $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64
