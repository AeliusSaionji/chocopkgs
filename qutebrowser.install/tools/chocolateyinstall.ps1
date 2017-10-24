$packageName = 'qutebrowser.install'
$installerType = 'exe'
$silentArgs = '/S'
$url = 'https://github.com/qutebrowser/qutebrowser/releases/download/v1.0.2/qutebrowser-1.0.2-win32.exe'
$url64 = 'https://github.com/qutebrowser/qutebrowser/releases/download/v1.0.2/qutebrowser-1.0.2-amd64.exe'
$checksum = '32604123db1e3318651eed03f54a25ceb920994006083eec841e980d1f960955'
$checksumType = 'sha256'
$checksum64 = 'ed9040549e121d39d26f81a86932295d749b9ff9db50002c0040b900d7bee92d'

Install-ChocolateyPackage $packageName $installerType $silentArgs $url $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64
