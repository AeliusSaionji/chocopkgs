$packageName = 'Honeyview.install'
$fileType = 'EXE'
$silentArgs = '/S'
$url = 'http://ca-dl.bandisoft.com/honeyview/HONEYVIEW-SETUP.EXE'
$url64 = $url
$checksum = '{{Checksum}}'
$checksumType = 'SHA512'
$checksum64 = '{{Checksumx64}}'
$checksumType64 = 'SHA512'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64
