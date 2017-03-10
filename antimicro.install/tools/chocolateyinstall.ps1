$packageName = 'antimicro.install'
$installerType = 'msi'
$silentArgs = '/qn /norestart'
$validExitCodes = @(0, 3010, 1641)
$version     = '{{PackageVersion}}'
$url         = "https://github.com/AntiMicro/antimicro/releases/download/$version/antimicro-$version-win32.msi"
$checksum = '{{Checksum}}'
$checksumType = 'SHA512'

Install-ChocolateyPackage $packageName $installerType $silentArgs -Url $url -ValidExitCodes $validExitCodes `
-Checksum $checksum -ChecksumType $checksumType
