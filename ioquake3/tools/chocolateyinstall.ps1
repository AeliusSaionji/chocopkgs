$packageName = 'ioquake3'
$version = '{{PackageVersion}}'
$url = "http://ioquake3.org/files/1.36/installer/ioquake3-1.36-3.1.x86.exe"
$urlDataInstaller = "http://ioquake3.org/files/1.36/data/ioquake3-q3a-1.32-1.x86.exe"
$checksum = '{{Checksum}}'
$checksumDataInstaller = '{{Checksumx64}}'
$checksumType  = 'md5'
$fileType = 'EXE'
$silentArgs = '/S' # NSIS
$validExitCodes= @(0)

Install-ChocolateyPackage $packageName $fileType $silentArgs $url -validExitCodes $validExitCodes -checksum $checksum -checksumType $checksumType
Install-ChocolateyPackage $packageName $fileType $silentArgs $urlDataInstaller -validExitCodes $validExitCodes -checksum $checksumDataInstaller -checksumType $checksumType

# test for steam, copy pak0 over
