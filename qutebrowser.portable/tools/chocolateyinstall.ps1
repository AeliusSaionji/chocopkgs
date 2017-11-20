$packageName = 'qutebrowser.portable'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$version = '{{PackageVersion}}'
$url = 'https://github.com/qutebrowser/qutebrowser/releases/download/v1.0.3/qutebrowser-1.0.3-windows-standalone-win32.zip'
$url64 = 'https://github.com/qutebrowser/qutebrowser/releases/download/v1.0.3/qutebrowser-1.0.3-windows-standalone-amd64.zip'
$checksum = 'bef8642f86d59af67a1e7ba79b5f815651565a8b362fcddfa73cdf4d52d87ffd'
$checksum64 = '29bb60e9f126ccf2eb6cc5178ff946c4f4d2ba55043283677fb0d18bb6e92feb'
$checksumType = 'sha256'

Install-ChocolateyZipPackage $packageName $url $toolsDir $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64
