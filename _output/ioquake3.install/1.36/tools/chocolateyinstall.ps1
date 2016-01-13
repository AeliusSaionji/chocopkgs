$packageName = 'ioquake3.install'
$version = '1.36'
$url = "http://ioquake3.org/files/1.36/installer/ioquake3-1.36-3.1.x86.exe"
$checksum = '0792b3854fc66dd99bbb26aa9cb2935f'
$checksumType  = 'md5'
$fileType = 'EXE'
$silentArgs = '/S' # NSIS
$validExitCodes= @(0)

Install-ChocolateyPackage $packageName $fileType $silentArgs $url -validExitCodes $validExitCodes -checksum $checksum -checksumType $checksumType
