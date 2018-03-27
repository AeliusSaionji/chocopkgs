$packageName = 'qutebrowser.install'
$installerType = 'exe'
$silentArgs = '/S'
$url = 'https://github.com/qutebrowser/qutebrowser/releases/download/v1.2.1/qutebrowser-1.2.1-win32.exe'
$url64 = 'https://github.com/qutebrowser/qutebrowser/releases/download/v1.2.1/qutebrowser-1.2.1-amd64.exe'
$checksum = '3b62c5f74ac4e067767435b53df5b3a0418ff54679765d3dfae0ddb4576b4e19'
$checksumType = 'sha256'
$checksum64 = '4e5495917787337ee4ff0631e66cb8b9afefe779a182ad464b0732a814efce68'

Install-ChocolateyPackage $packageName $installerType $silentArgs $url $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64
