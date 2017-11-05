$packageName = 'qutebrowser.install'
$installerType = 'exe'
$silentArgs = '/S'
$url = 'https://github.com/qutebrowser/qutebrowser/releases/download/v1.0.3/qutebrowser-1.0.3-win32.exe'
$url64 = 'https://github.com/qutebrowser/qutebrowser/releases/download/v1.0.3/qutebrowser-1.0.3-amd64.exe'
$checksum = 'f11dec20009f40e6109f3328e9f52a0e506fcdd24b009f14ae1ea8bea33311b1'
$checksumType = ''
$checksum64 = '71e5b261b1455a9600f6fdd94083e8b6091318dd770ea1f7b0520992e726b28f'

Install-ChocolateyPackage $packageName $installerType $silentArgs $url $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64
