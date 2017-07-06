$packageName = 'qutebrowser.install'
$installerType = 'exe'
$silentArgs = '/S'
$url = 'https://github.com/qutebrowser/qutebrowser/releases/download/v0.11.0/qutebrowser-0.11.0-win32.exe'
$url64 = 'https://github.com/qutebrowser/qutebrowser/releases/download/v0.11.0/qutebrowser-0.11.0-amd64.exe'
$checksum = '707e1de843940824765d65df5d3f74163d1cecbad5c44fdaed6ade832f30a94e'
$checksumType = 'sha256'
$checksum64 = '738cec9b8e393e70977f846533ebe07fff4d7ba69e2a969eb511fc412d6039d6'

Install-ChocolateyPackage $packageName $installerType $silentArgs $url $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64
