$packageName = 'qutebrowser.install'
$installerType = 'exe'
$silentArgs = '/S'
$url = 'https://github.com/qutebrowser/qutebrowser/releases/download/v1.3.1/qutebrowser-1.3.1-win32.exe'
$url64 = 'https://github.com/qutebrowser/qutebrowser/releases/download/v1.3.1/qutebrowser-1.3.1-amd64.exe'
$checksum = '0ea39e4cd10c0989289382ed56d0d25d5432ce1f50e86d1b3bd1af09da1ba9e2'
$checksumType = 'sha256'
$checksum64 = '21cb64dec544212ec7362f90d06149a26aa4a49c689d16d7ef4263b69175270d'

Install-ChocolateyPackage $packageName $installerType $silentArgs $url $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64
