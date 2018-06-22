$packageName = 'qutebrowser.portable'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://github.com/qutebrowser/qutebrowser/releases/download/v1.3.3/qutebrowser-1.3.3-windows-standalone-win32.zip'
$url64 = 'https://github.com/qutebrowser/qutebrowser/releases/download/v1.3.3/qutebrowser-1.3.3-windows-standalone-amd64.zip'
$checksum = 'aae46de5042369ebf3478623dc1bdc98c22a4709da2a8be86e9c1e4d7d956121'
$checksum64 = 'f01ad33c2ad61c1bf758997eb7c677b2dda6f9de36850f85ca003b54de5e7ea0'
$checksumType = 'sha256'

Install-ChocolateyZipPackage $packageName $url $toolsDir $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64
