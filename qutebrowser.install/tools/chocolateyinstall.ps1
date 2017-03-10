$packageName = 'qutebrowser.install'
$installerType = 'msi'
$silentArgs = '/qn /norestart'
$validExitCodes = @(0, 3010, 1641)
$version = '{{PackageVersion}}'
$url = "https://github.com/The-Compiler/qutebrowser/releases/download/v$version/qutebrowser-$version-win32.msi"
$url64 = "https://github.com/The-Compiler/qutebrowser/releases/download/v$version/qutebrowser-$version-amd64.msi"
$checksum = '{{Checksum}}'
$checksumType = 'SHA512'
$checksum64 = '{{Checksumx64}}'

Install-ChocolateyPackage $packageName $installerType $silentArgs $url $url64 $validExitCodes `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64
