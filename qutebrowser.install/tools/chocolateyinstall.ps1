$packageName = 'qutebrowser.install'
$installerType = 'exe'
$silentArgs = '/S'
$url = 'https://github.com/qutebrowser/qutebrowser/releases/download/v1.3.3/qutebrowser-1.3.3-win32.exe'
$url64 = 'https://github.com/qutebrowser/qutebrowser/releases/download/v1.3.3/qutebrowser-1.3.3-amd64.exe'
$checksum = 'd82e3f700c2bc0d6e77b58bd36a5e9614058d142ae70b90d95a76002b0c16d0b'
$checksumType = 'sha256'
$checksum64 = 'd62c9dd003aecd9830251c584a7bb40cdfc3b336488c1067ac3af60685f4016f'

Install-ChocolateyPackage $packageName $installerType $silentArgs $url $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64
