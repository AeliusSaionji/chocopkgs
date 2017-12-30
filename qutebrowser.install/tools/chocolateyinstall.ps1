$packageName = 'qutebrowser.install'
$installerType = 'exe'
$silentArgs = '/S'
$url = 'https://github.com/qutebrowser/qutebrowser/releases/download/v1.0.4/qutebrowser-1.0.4-win32.exe'
$url64 = 'https://github.com/qutebrowser/qutebrowser/releases/download/v1.0.4/qutebrowser-1.0.4-amd64.exe'
$checksum = 'fa13d9263e4447e70fb3be41c499ad8b9782f6f40ed51976ae189b0fc22abd80'
$checksumType = 'sha256'
$checksum64 = 'bd198402113b737948a30637cd454b774f31b7aec032f3ab00762fc91f239a0a'

Install-ChocolateyPackage $packageName $installerType $silentArgs $url $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64
