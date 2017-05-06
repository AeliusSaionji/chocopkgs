$packageName = 'geforce-experience'
$installerType = 'EXE'
$version = '{{PackageVersion}}'
$url = "http://us.download.nvidia.com/GFE/GFEClient/$version/GeForce_Experience_v$version.exe"
$silentArgs = '/s /noreboot'
$validExitCodes = @(0)
$checksum = '{{Checksum}}'
$checksumType = 'SHA512'

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -validExitCodes $validExitCodes `
-Checksum $checksum -ChecksumType $checksumType

Write-Output "If you experience errors after updating, you may need to reboot."
