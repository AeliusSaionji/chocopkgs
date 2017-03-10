$packageName = 'Honeyview.install'
$fileType = 'EXE'
$silentArgs = '/S'
$url = 'https://dl.bandisoft.com/honeyview/HONEYVIEW-SETUP.EXE'
$url64 = $url
$checksum = '{{Checksum}}'
$checksum64 = '{{Checksumx64}}'
$checksumType = 'SHA512'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64 `
-Checksum $checksum -ChecksumType $checksumType -Checksum64 $checksum64
