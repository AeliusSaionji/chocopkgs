$packageName = 'qutebrowser.install'
$installerType = 'exe'
$silentArgs = '/S'
$url = 'https://github.com/qutebrowser/qutebrowser/releases/download/v1.1.1/qutebrowser-1.1.1-win32.exe'
$url64 = 'https://github.com/qutebrowser/qutebrowser/releases/download/v1.1.1/qutebrowser-1.1.1-amd64.exe'
$checksum = '564a139591a5d613daa7c5224c28406cd80dc8a4771156641b6735bc5990012e'
$checksumType = 'sha256'
$checksum64 = '193359d2620004ca0701f5fed67cbdeef7e3ab49084530aec735b89507030f5c'

Install-ChocolateyPackage $packageName $installerType $silentArgs $url $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64
