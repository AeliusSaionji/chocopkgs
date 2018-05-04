$packageName = 'qutebrowser.install'
$installerType = 'exe'
$silentArgs = '/S'
$url = 'https://github.com/qutebrowser/qutebrowser/releases/download/v1.3.0/qutebrowser-1.3.0-win32.exe'
$url64 = 'https://github.com/qutebrowser/qutebrowser/releases/download/v1.3.0/qutebrowser-1.3.0-amd64.exe'
$checksum = 'cc3b2c825fa8c0dbe6984f6d044cc00887e698683625b00037c0ce525a42957c'
$checksumType = 'sha256'
$checksum64 = '7729cf094dc213b84251196c0cfadf0c73b31afce43ef005f1c4687859cad54b'

Install-ChocolateyPackage $packageName $installerType $silentArgs $url $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64
